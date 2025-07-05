import wollok.game.*
import niveles.*
import powerUps.*



object jugador{
    var property position = game.origin()//game.at(0, 0)
    var positionAnterior = game.origin()
    var energia = 100
    var property resistencia = 1
    var archivosRecolectados = 0     

    method energia() = energia 

    method usarPowerUp(unPowerUp){
        unPowerUp.activar()         
    }

    method posicion(nueva) {
        if (nueva.x() >= 0 && nueva.x() < game.width() && nueva.y() >= 0 && nueva.y() < game.height()){
        positionAnterior = position
        position = nueva}}

    method limpiarArchivos(){archivosRecolectados = 0}

    method restaurarEnergia(){energia = 100}

    method recolectar(){
        archivosRecolectados +=1}

    method recibirDaño(unEnemigo){
        if(self.estaMuerto()){
            //game.say(self, 'Estoy sin energia!')
            escenario.reiniciarNivel()}
        else{
             if (resistencia == 1){
                energia = (energia - unEnemigo.danio()).max(0)
               }
            else {
                energia = (energia - unEnemigo.danio()/resistencia).max(0)
              } }       
    } 

    method image() = if (resistencia==1) "hacker.png" else 'hacker_escudo.png'  
	
    method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

    method cuantosArchivos() = archivosRecolectados

    method mensajeArchivos() = 'Tengo '+ archivosRecolectados  +' archivos'
    
    method mensajeEnergia() = 'Tengo '+ energia  +' de energia'
    
    method estaMuerto() = energia == 0   

    method retroceder(){position = positionAnterior} 
}
    

object indicadorEnergia{
    var property position =game.at(0,7)

    method text() = "            ENERGIA: " + jugador.energia().toString()

    method textColor() = paleta.rojo()

    method chocar(unJugador){}
}

object indicadorDatos{
    var property position =game.at(0,6)

    method text() = "     DATOS: " + jugador.cuantosArchivos().toString()

    method textColor() = paleta.blanco()

    method chocar(unJugador){}
}

object paleta {
  const property verde = "00FF00FF"
  const property rojo = "FF0000FF"
  const property blanco = "FFFFFFFF"
}
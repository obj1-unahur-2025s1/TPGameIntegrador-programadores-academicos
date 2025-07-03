import wollok.game.*
import niveles.*
import powerUps.*



object jugador{
    var property position = game.origin()//game.at(0, 0)
    var energia = 100
    var property resistencia = 1
    var archivosRecolectados = 0     

    method energia() = energia 
    method usarPowerUp(unPowerUp){
        unPowerUp.activar()         
    }
    method limpiarArchivos(){archivosRecolectados = 0}
    method restaurarEnergia(){energia = 100}
    method recolectar(){
        archivosRecolectados +=1
        game.say(self, self.mensajeArchivos())}
    method recibirDaño(unEnemigo){
        if(self.estaMuerto()){
            game.say(self, 'Estoy sin energia!')
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
    
}

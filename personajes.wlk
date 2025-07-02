import wollok.game.*
import niveles.*
import powerUps.*

object escenario{
    const listaNiveles =[nivel1, nivel2, nivel3]
    var nivelActual = 0
    
    method condicionDeSalida() = listaNiveles.get(nivelActual).concondicionDeSalida()
    method iniciar(){
        listaNiveles.get(nivelActual).iniciar()
        }
    method pasarDeNivel() {
        listaNiveles.get(nivelActual).removerTodo()
        nivelActual += 1
        if (nivelActual < listaNiveles.size()) {
        listaNiveles.get(nivelActual).iniciar()
    }
    }

}


object jugador{
    var property position = game.origin()//game.at(0, 0)
    var energia = 100
    var property resistencia = 1
    var archivosRecolectados = 0
    const powerUpsActivos = []

    method usarPowerUp(unPowerUp){
        unPowerUp.activar()
        powerUpsActivos.add(unPowerUp)
    }
    method recolectar(){archivosRecolectados +=1}
    method recibirDaño(unEnemigo){
        if (resistencia == 1){
            energia = energia - unEnemigo.danio()
        }
        else {
            energia = energia - unEnemigo.danio()/resistencia
        }        
    }  
    method image() = if (resistencia==1) "Hacker1.png" else 'Hacker2.png'  
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
    method cuantosArchivos() = archivosRecolectados
    method mensaje() = 'tengo '+ archivosRecolectados  +' archivos y energia '+ energia
    method verificarSalida(unElemento) = unElemento.puedeSalir(self)
    method nivelQueEsta()
    
}
class Archivo{
    var property position

    method image() = 'archivoA.png'
    method chocar(unJugador) {
        unJugador.recolectar()
        game.removeVisual(self)
    }   
}
class Enemigo{
    var property position //= game.center()
    var techo = false
    method danio() = 5
    method chocar(unJugador) {
        unJugador.recibirDaño(self)
    } 

}
class Explosivo inherits Enemigo{

    method image() = "bomb.png"

    method mover() {
        if(not techo and position.x() < 7) position = position.right(1)
        if(techo and position.x() > 0 ) position = position.left(1)
        if(position.x() == 7) techo = true
        if(position.x() == 0) techo = false
        }
    override method danio() = super()*3    
}
class Simpatico inherits Enemigo{ 

    method image() = "Enemigo2.png"

    method mover() {
        if(not techo and position.y() < 7) position = position.up(1)
        if(techo and position.y() > 0 ) position = position.down(1)
        if(position.y() == 7) techo = true
        if(position.y() == 0) techo = false
        }    
}
class Feo inherits Enemigo{

    method image() = "Enemigo4.png"

    method mover(){
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x,y)
    }
    override method danio() = super() +2
}
class Raro inherits Enemigo{

    method image() = "Enemigo3.png"

    method mover() {
        if(not techo and position.x() < 7) position = position.right(1)
        if(techo and position.x() > 0 ) position = position.left(1)
        if(position.x() == 7) techo = true
        if(position.x() == 0) techo = false
        }
    override method danio() = super() + super()*0.2    
}
object puertaSalida{
    var property position = game.at(7,7)
    var estaAbierta = false
    
    method image() = 'puerta.jpg' 
    method chocar(unJugador){
        if(self.puedeSalir(unJugador, unEscenario)){
            self.abrir()
            unEscenario.pasarDeNivel()}
    }
    method abrir() {estaAbierta=true} 
   
    method puedeSalir(unJugador, unEscenario) = unJugador.cuantosArchivos() == unEscenario.condicionDeSalidad()
}


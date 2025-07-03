import wollok.game.*
import personajes.*
import powerUps.*
import niveles.*

class Archivo{
    var property position

    method image() = 'archivo_secreto.png'
    method chocar(unJugador) {
        unJugador.recolectar()
        unJugador.mensajeArchivos()
        game.removeVisual(self)
    }   
}

object puertaSalida{
    var property position = game.at(7,7)
    var estaAbierta = false
    
    method image() = 'puerta_salida.png' 
    method chocar(unJugador){
        if(self.puedeSalir(unJugador)){
            self.abrir()
            escenario.pasarDeNivel()}
        else{
            game.say(jugador, 'No puedo pasar de nivel')
        }    
    }
    method abrir() {estaAbierta=true} 
   
    method puedeSalir(unJugador) = unJugador.cuantosArchivos() ==  escenario.condicionDeSalida()
}

object pantallaInicial{

    var property position = game.origin()

    method image() = 'Pantalla_inicio.jpg'

    method chocar(unJugador){}

}
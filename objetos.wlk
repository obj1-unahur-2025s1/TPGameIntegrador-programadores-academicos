import wollok.game.*
import personajes.*
import powerUps.*
import niveles.*

class Archivo{
    var property position

    method image() = 'archivo_secreto.png'
    method chocar(unJugador) {
        unJugador.recolectar()
        //unJugador.mensajeArchivos()
        game.removeVisual(self)
        game.sound("collect.mp3").play()
    }   
}

object puertaSalida{
    var property position = game.at(7,7)
    var estaAbierta = false
    var yaChoco = false
    
    method image() = 'puerta_salida.png' 

    method chocar(unJugador){
        if(self.puedeSalir(unJugador)){
            self.abrir()
            escenario.pasarDeNivel()
            game.sound("door -o.mp3").play()} // ---Sonido al abrirla
        else if(self.puedeSalirDificil(unJugador)){
            self.abrir()
            escenario.pasarDeNivelDificil()
            game.sound("door -o.mp3").play()} // ---Sonido al abrirla
        
        else{
            //game.say(jugador, 'No puedo abrirla')
            self.puertaCerrada()
            
        }    
    }

    method puertaCerrada(){if (not yaChoco){
        yaChoco = true
        game.sound("door-un.mp3").play()// ---Sonido puerta cerrada (rompe el juego si se colisiona mucho)
        game.onTick(1000, "descanso", {yaChoco = false})
        }
    }

    method abrir() {estaAbierta=true} 
   
    method puedeSalir(unJugador) = unJugador.cuantosArchivos() ==  escenario.condicionDeSalida()

    method puedeSalirDificil(unJugador) = unJugador.cuantosArchivos() ==  escenario.condicionDeSalidaDificil()
}

object pantallaInicial{

    var property position = game.origin()

    method image() = 'Pantalla_inicio.jpg'

    method chocar(unJugador){}

}


class Obstaculo{
    var property position

    method image() = 'computer.png'

    method chocar(unJugador){unJugador.retroceder()}

}
import wollok.game.*
import personajes.*
import niveles.*


object armadura {
    var property position = game.at(3,3)
    method image() = 'armadura.png'

    method activar(unJugador){
        unJugador.resistencia(2)
        game.onTick(10000, 'desactivarPoder', {unJugador.resistencia(1)})
    }
    method chocar(unJugador){
        self.activar(unJugador)
        //game.say(jugador, 'Poder Activado')
        game.removeVisual(self)
        game.sound("shield-guard.mp3").play()
    }
}

object relojCibernetico {
  var property position =  escenario.posicionAleatoria()
   method image() = 'relojfutu.png'

     method activar(unJugador){
      escenario.obtenerNivelActual().detenerEnemigosTemporalmente()
    }
    method chocar(unJugador){
        self.activar(unJugador)
        game.removeVisual(self)
        game.sound("clock-ticking.mp3").play()
    }
}


object recargaEnergia{
    var property position = escenario.posicionAleatoria()
    method image() = 'Pila.png'

    method activar(unJugador){
        unJugador.curar()
    }

    method chocar(unJugador){
        self.activar(unJugador)
        game.removeVisual(self)

    }
}
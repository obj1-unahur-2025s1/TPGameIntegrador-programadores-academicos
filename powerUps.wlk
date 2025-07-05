import wollok.game.*
import personajes.*


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
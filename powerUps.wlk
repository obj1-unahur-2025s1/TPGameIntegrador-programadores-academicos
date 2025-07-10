import wollok.game.*
import personajes.*


object armadura {
    var property position = self.posicionAleatoria()
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
    method posicionAleatoria() = game.at((0..9).anyOne(),(0..9).anyOne())
}


object recargaEnergia{
    var property position = self.posicionAleatoria()
    method image() = 'Pila.png'

    method activar(unJugador){
        unJugador.curar()
    }

    method chocar(unJugador){
        self.activar(unJugador)
        game.removeVisual(self)

    }
    method posicionAleatoria() = game.at((0..9).anyOne(),(0..9).anyOne())
}
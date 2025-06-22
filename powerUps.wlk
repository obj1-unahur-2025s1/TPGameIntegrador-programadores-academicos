import personajes.*

class PowerUp{

    method activar(unJugador){

    }
}

object imanDeArchivos inherits PowerUp{
    override method activar(unJugador){

    }
}

object rayoDeVelocidad inherits PowerUp{
    override method activar(unJugador){
        unJugador.velocidad=(unJugador.velocidad)*2
    }
}
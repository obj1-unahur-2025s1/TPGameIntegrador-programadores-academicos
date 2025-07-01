import personajes.*

class PowerUp{

    method activar(unJugador){

    }
}

object imanDeArchivos inherits PowerUp{
    override method activar(unJugador){

    }
}

object armadura inherits PowerUp{
    override method activar(unJugador){
        unJugador.resistencia(2)
    }
}
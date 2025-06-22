import wollok.game.*
object jugador{
    var posicion = game.at(0, 0)
    var energia = 0
    var property velocidad = 0
    var archivosRecolectados = []
    var powerUpsActivos = []

    method recolectar(unArchivo){
        archivosRecolectados.add(unArchivo)
        unArchivo.serRecolectado()
    }

    method usarPowerUp(unPowerUp){
        unPowerUp.activar()
        powerUpsActivos.add(unPowerUp)
    }

    method recibirDaño(unaCantidad){
        energia = energia - unaCantidad
    }

  
  method image() = "hacker_50x50 (1).png"
  method position() = posicion
  method position(p) { posicion = p }
  
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
    
}

object puertaSalida{
    var estaAbierta = false

    method abrir(){
        estaAbierta=true
    }

    method verificar(listaDeArchivos){
        
    }
}

object fondo{
    method position()=game.at(0,0)

    method image()="fondo_final2.jpg"

}

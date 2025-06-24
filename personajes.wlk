import wollok.game.*

object gemu{

    method iniciar(){
        const enemigo1 = new Explosivo(position = game.at(6,4))
        const enemigo2 = new Simpatico(position = game.at(4,1))
        const enemigo3 = new Feo(position = game.at(6,6))
        const enemigo4 = new Raro(position = game.at(2,2))
        game.width(8)
        game.height(8)
      //game.cellSize(50)
        game.title("Hackeando la Red")
  
 
        game.boardGround("fondo_final2.jpg")
        game.addVisualCharacter(jugador)
        game.addVisual(enemigo1)
        game.addVisual(enemigo2)
        game.addVisual(enemigo3)
        game.addVisual(enemigo4)

        game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo4.mover();enemigo3.mover()})
        
        }
    

}


object jugador{
    var property position = game.origin()//game.at(0, 0)
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

  
    method image() = "Hacker1.png"

  
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
    
}



class Enemigo{
    var property position //= game.center()
    var techo = false

}

class Explosivo inherits Enemigo{

    method image() = "bomb.png"

    method mover() {
        if(not techo and position.x() < 7) position = position.right(1)
        if(techo and position.x() > 0 ) position = position.left(1)
        if(position.x() == 7) techo = true
        if(position.x() == 0) techo = false
        }

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
}

class Raro inherits Enemigo{

    method image() = "Enemigo3.png"

    method mover() {
        if(not techo and position.x() < 7) position = position.right(1)
        if(techo and position.x() > 0 ) position = position.left(1)
        if(position.x() == 7) techo = true
        if(position.x() == 0) techo = false
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

//object fondo{
 //   method position()=game.at(0,0)

 //   method image()="fondo_final2.jpg"}

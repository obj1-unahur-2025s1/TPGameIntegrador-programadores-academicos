import wollok.game.*

object gemu{

    method iniciar(){
        const enemigo1 = new Explosivo(position = game.at(6,4))
        const enemigo2 = new Simpatico(position = game.at(4,1))
        const enemigo3 = new Feo(position = game.at(6,6))
        const enemigo4 = new Raro(position = game.at(2,2))
        const archivo1 = new Archivo(position = game.at(5,5))
        const archivo2 =new Archivo(position = game.at(0,3))
        const archivo3 = new Archivo(position = game.at(6,0))
        
        game.title("Hackeando la Red")
        game.width(8)
        game.height(8)
        game.boardGround("fondo_final2.jpg")
        game.addVisualCharacter(jugador)
        game.addVisual(enemigo1)
        game.addVisual(enemigo2)
        game.addVisual(enemigo3)
        game.addVisual(enemigo4)
        game.addVisual(archivo1)
        game.addVisual(archivo2)
        game.addVisual(archivo3)

        game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo4.mover();enemigo3.mover()})
        
        }
    

}


object jugador{
    var property position = game.origin()//game.at(0, 0)
    var energia = 100
    var property resistencia = 1
    const archivosRecolectados = []
    const powerUpsActivos = []

   method recolectar(unElemento){
        if(unElemento.toString() == 'an Archivo'){
            archivosRecolectados.add(unElemento)
        }
        else{
            self.recibirDaño(unElemento.danio())
        }
        
         
    }
    method usarPowerUp(unPowerUp){
        unPowerUp.activar()
        powerUpsActivos.add(unPowerUp)
    }

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
    method cuantosArchivos()= 'tengo estos '+ archivosRecolectados.size() +' archivos y esta energia '+ energia
    
}
class Archivo{
    var property position

    method image() = 'archivoA.png'
   
}



class Enemigo{
    var property position //= game.center()
    var techo = false
    method danio() = 5

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

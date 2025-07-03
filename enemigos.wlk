import wollok.game.*
import personajes.*
import powerUps.*
import niveles.*


class Enemigo{
    var property position //= game.center()
    var techo = false
    method danio() = 5
    method chocar(unJugador) {
         unJugador.recibirDaño(self)
         game.say(jugador, jugador.mensajeEnergia())		 
    } 

}
class Firewall inherits Enemigo{

    method image() = "firewall.png"

    method mover() {
        if(not techo and position.x() < 7) position = position.right(1)
        if(techo and position.x() > 0 ) position = position.left(1)
        if(position.x() == 7) techo = true
        if(position.x() == 0) techo = false
        }
    override method danio() = super()*3    
}
class IATraidora inherits Enemigo{ 

    method image() = "IA_Traidora.png"

    method mover() {
        if(not techo and position.y() < 7) position = position.up(1)
        if(techo and position.y() > 0 ) position = position.down(1)
        if(position.y() == 7) techo = true
        if(position.y() == 0) techo = false
        }    
}
class RobotAntivirus inherits Enemigo{

    method image() = "robot_antivirus.png"

    method mover(){
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x,y)
    }
    override method danio() = super() + 2
}
class VigilanteIDS inherits Enemigo{

    method image() = "vigilante_ids.png"

    method mover() {
        if(not techo and position.x() < 7) position = position.right(1)
        if(techo and position.x() > 0 ) position = position.left(1)
        if(position.x() == 7) techo = true
        if(position.x() == 0) techo = false
        }
    override method danio() = super() + super()*0.2    
}
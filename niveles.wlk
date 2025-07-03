import wollok.game.*
import personajes.*
import powerUps.*

object nivel1 {
  const elementosNivel = [] 
  method agregarTodos(unaLista) = elementosNivel.addAll(unaLista) 
  method iniciar(){
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const archivo1 = new Archivo(position = game.at(5,5))
    const archivo2 = new Archivo(position = game.at(0,3))
    const archivo3 = new Archivo(position = game.at(6,0))    
    self.agregarTodos([enemigo1,enemigo2,enemigo3,archivo1,archivo2,archivo3,jugador,puertaSalida, armadura ])
    game.addVisual(armadura)      
    game.addVisual(enemigo1)
    game.addVisual(enemigo2)
    game.addVisual(enemigo3)
    game.addVisual(archivo1)
    game.addVisual(archivo2)
    game.addVisual(archivo3)
    game.addVisual(puertaSalida)
    game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover()})
  }
  method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
  }
  method condicionDeSalida() = 3
}
object nivel2 {
    const elementosNivel = [] 
    method agregarTodos(unaLista) = elementosNivel.addAll(unaLista) 
    method iniciar(){     
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const enemigo4 = new VigilanteIDS(position = game.at(2,2)) 
    const archivo1 = new Archivo(position = game.at(5,5))
    const archivo2 = new Archivo(position = game.at(0,3))
    const archivo3 = new Archivo(position = game.at(6,0))
    const archivo4 = new Archivo(position = game.at(2,7))
    self.agregarTodos([enemigo1,enemigo2,enemigo3,enemigo4,archivo1,archivo2,archivo3,archivo4,armadura, 
                        jugador,puertaSalida])
    game.addVisual(armadura)     
    game.addVisual(enemigo1)
    game.addVisual(enemigo2)
    game.addVisual(enemigo3)
    game.addVisual(enemigo4)
    game.addVisual(archivo1)
    game.addVisual(archivo2)
    game.addVisual(archivo3)
    game.addVisual(archivo4)
    game.addVisual(puertaSalida)
    game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover();enemigo4.mover()})
  }
  method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
  }
  method condicionDeSalida() = 4
}
object nivel3 {
    const elementosNivel = [] 
    method agregarTodos(unaLista) = elementosNivel.addAll(unaLista) 
    method iniciar(){    
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const enemigo4 = new VigilanteIDS(position = game.at(2,2)) 
    const enemigo5 = new Firewall(position = game.at(4,6))
    const archivo1 = new Archivo(position = game.at(5,5))
    const archivo2 = new Archivo(position = game.at(0,3))
    const archivo3 = new Archivo(position = game.at(6,0))
    const archivo4 = new Archivo(position = game.at(2,7))
    const archivo5 = new Archivo(position = game.at(7,2))
    self.agregarTodos([enemigo1,enemigo2,enemigo3,enemigo4,enemigo5,armadura, 
                     archivo1,archivo2,archivo3,archivo4,archivo5, jugador,puertaSalida])
    game.addVisual(armadura)                      
    game.addVisual(enemigo1)
    game.addVisual(enemigo2)
    game.addVisual(enemigo3)
    game.addVisual(enemigo4)
    game.addVisual(enemigo5)
    game.addVisual(archivo1)
    game.addVisual(archivo2)
    game.addVisual(archivo3)
    game.addVisual(archivo4)
    game.addVisual(archivo5)
    game.addVisual(puertaSalida)
    game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover();enemigo4.mover();enemigo5.mover()})
    }
    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
  }
  method condicionDeSalida() = 5
  
}
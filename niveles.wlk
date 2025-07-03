import wollok.game.*
import personajes.*
import powerUps.*
import enemigos.*
import objetos.*



object escenario{
    const listaNiveles =[nivelBase, nivel1, nivel2, nivel3]
    var nivelActual = 0
    var juegoIniciado = false

    method iniciarJuego(){
      juegoIniciado=true
      
      self.pasarDeNivel()
    }
    method estadoJuego()=juegoIniciado

  method iniciarInstrucciones(){
    game.addVisual(pantallaInstrucciones)
  }
  method removerGameOver(){
    game.removeVisual(gameOver)
  }

  method removerInstrucciones(){
    game.removeVisual(pantallaInstrucciones)
  }
     
    method condicionDeSalida() = listaNiveles.get(nivelActual).condicionDeSalida()
    method iniciar(){
        listaNiveles.get(nivelActual).iniciar()
        }
    method pasarDeNivel() {
        listaNiveles.get(nivelActual).removerTodo()
        nivelActual += 1
        if (nivelActual < listaNiveles.size()) {
            jugador.position(game.origin())
            jugador.restaurarEnergia()
            jugador.limpiarArchivos() 
            game.addVisual(jugador)           
            listaNiveles.get(nivelActual).iniciar()
            game.say(jugador, 'Nuevo Nivel!')
        }
        else{
            game.addVisual(gameOver)
            keyboard.space().onPressDo{self.reinicioDeJuego()
            game.removeVisual(gameOver)}
            
        }
    }
    method reiniciarNivel(){
        listaNiveles.get(nivelActual).removerTodo()
        jugador.position(game.origin())
        jugador.restaurarEnergia()
        jugador.limpiarArchivos()   
        jugador.resistencia(1)
        game.addVisual(jugador) 
        listaNiveles.get(nivelActual).iniciar() 
        game.say(jugador, 'Nivel Reiniciado!')        
    }

  method reinicioDeJuego(){        
        nivelActual = 0
        juegoIniciado = false
        listaNiveles.get(nivelActual).removerTodo()
        jugador.position(game.origin())
        jugador.restaurarEnergia()
        jugador.limpiarArchivos()   
        jugador.resistencia(1)        
        game.addVisual(jugador) 
        listaNiveles.get(nivelActual).iniciar()       
        game.say(jugador, 'Volver a Sufrir')
    }

}

object pantallaInstrucciones{

    var property position = game.origin()
    method image() = 'instrucciones.png'
    method chocar(unJugador){}

}

object gameOver{
  var property position=game.origin()
  method image()='gameOver.png'
  method chocar(unJugador){}

}

object nivelBase{

    method iniciar(){
      game.addVisual(pantallaInicial)
    }

    method removerTodo(){
      game.removeVisual(pantallaInicial)
      game.removeVisual(jugador)

    }

}

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
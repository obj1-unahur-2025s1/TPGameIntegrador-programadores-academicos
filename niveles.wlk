import wollok.game.*
import personajes.*
import powerUps.*
import enemigos.*
import objetos.*

object escenario{
    const listaNiveles =[nivelBase, nivel1, nivel2, nivel3]
    const listaNivelesDificiles = [nivelBase,nivel1D,nivel2D,nivel3D] // Proximamente...
    var nivelActual = 0
    var juegoIniciado = false
    const musicaTitulo = game.sound("Mega Man 3 (NES) Music - Title Theme.mp3") //-----Musica
    const musicaJuego = game.sound("Muladhara - Digital Devil Saga 1.mp3")
    


    method iniciarJuego(){
      juegoIniciado=true
      
      self.pasarDeNivel()
  }

    method iniciarJuegoDificil(){
      juegoIniciado=true
      
      self.pasarDeNivelDificil()
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

    method condicionDeSalidaDificil() = listaNivelesDificiles.get(nivelActual).condicionDeSalida()



    method iniciar(){if(nivelActual == 0){
        listaNiveles.get(nivelActual).iniciar()
        musicaTitulo.shouldLoop(true)// ------ Reinicia
        musicaTitulo.play()//----Ejecuta
    } else {
      listaNiveles.get(nivelActual).iniciar()
    }
        
  }

    method pasarDeNivel() {
        listaNiveles.get(nivelActual).removerTodo()
        nivelActual += 1
        
        if (nivelActual < listaNiveles.size()) {
          if (nivelActual == 1){
            musicaTitulo.stop()//Detener
            musicaJuego.shouldLoop(true)
            musicaJuego.play()} 
            jugador.position(game.origin())
            //jugador.restaurarEnergia() //--- Resta dificultad
            jugador.limpiarArchivos() 
            //game.addVisual(jugador)           
            listaNiveles.get(nivelActual).iniciar()
            //game.say(jugador, 'Nuevo Nivel!')
        }
        else{
            game.addVisual(gameOver)
            keyboard.space().onPressDo{
            self.reinicioDeJuego()
            game.removeVisual(gameOver)}
            }
  }




    method pasarDeNivelDificil() {
        listaNivelesDificiles.get(nivelActual).removerTodo()
        nivelActual += 1
        
        if (nivelActual < listaNivelesDificiles.size()) {
          if (nivelActual == 1){
            musicaTitulo.stop()//Detener
            musicaJuego.shouldLoop(true)
            musicaJuego.play()} 
            jugador.position(game.origin())
            //jugador.restaurarEnergia() //--- Resta dificultad
            jugador.limpiarArchivos() 
            //game.addVisual(jugador)           
            listaNivelesDificiles.get(nivelActual).iniciar()
            //game.say(jugador, 'Nuevo Nivel!')
        }
        else{
            game.addVisual(gameOver)
            keyboard.space().onPressDo{
            self.reinicioDeJuego()
            game.removeVisual(gameOver)}
            }
  }


    method reiniciarNivel(){              //--- Metodo innecesario
        listaNiveles.get(nivelActual).removerTodo()
        jugador.position(game.origin())
        jugador.restaurarEnergia()
        jugador.limpiarArchivos()   
        jugador.resistencia(1)
        //game.addVisual(jugador) 
        listaNiveles.get(nivelActual).iniciar() 
        //game.say(jugador, 'Nivel Reiniciado!')        
    }

  method reinicioDeJuego(){        
        nivelActual = 0
        juegoIniciado = false
        musicaJuego.stop()
        musicaTitulo.shouldLoop(true)// ------ Reinicia
        musicaTitulo.play()//----Ejecuta
        //listaNiveles.get(nivelActual).removerTodo()
        jugador.position(game.origin())
        jugador.restaurarEnergia()
        jugador.limpiarArchivos()   
        jugador.resistencia(1)        
        //game.addVisual(jugador) 
        listaNiveles.get(nivelActual).iniciar()       
        //game.say(jugador, 'Volver a Sufrir')
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
      //game.removeVisual(jugador)

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
    self.agregarTodos([enemigo1,enemigo2,enemigo3,archivo1,archivo2,archivo3,puertaSalida, armadura,jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)})

    //game.addVisual(armadura)      
    //game.addVisual(enemigo1)
    //game.addVisual(enemigo2)
    //game.addVisual(enemigo3)
    //game.addVisual(archivo1)
    //game.addVisual(archivo2)
    //game.addVisual(archivo3)
    //game.addVisual(puertaSalida)
    //game.addVisual(indicadorEnergia)
    //game.addVisual(indicadorDatos)
    //game.addVisual(jugador)
    game.addVisual(new Obstaculo(position = game.at(3,5))) // --Probando obstaculo
    game.onTick(600, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover()})
  }

  method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
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
    self.agregarTodos([enemigo1,enemigo2,enemigo3,enemigo4,archivo1,archivo2,archivo3,archivo4,armadura,puertaSalida, 
                        jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)})

    //game.addVisual(armadura)     
    //game.addVisual(enemigo1)
    //game.addVisual(enemigo2)
    //game.addVisual(enemigo3)
    //game.addVisual(enemigo4)
    //game.addVisual(archivo1)
    //game.addVisual(archivo2)
    //game.addVisual(archivo3)
    //game.addVisual(archivo4)
    //game.addVisual(puertaSalida)
    //game.addVisual(indicadorEnergia)
    //game.addVisual(indicadorDatos)
    //game.addVisual(jugador)
    game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover();enemigo4.mover()})
  }
  method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
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
                     archivo1,archivo2,archivo3,archivo4,archivo5,puertaSalida,jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)}) 

    //game.addVisual(armadura)                      
    //game.addVisual(enemigo1)
    //game.addVisual(enemigo2)
    //game.addVisual(enemigo3)
    //game.addVisual(enemigo4)
    //game.addVisual(enemigo5)
    //game.addVisual(archivo1)
    //game.addVisual(archivo2)
    //game.addVisual(archivo3)
    //game.addVisual(archivo4)
    //game.addVisual(archivo5)
    //game.addVisual(puertaSalida)
    //game.addVisual(indicadorEnergia)
    //game.addVisual(indicadorDatos)
    //game.addVisual(jugador)
    game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover();enemigo4.mover();enemigo5.mover()})
    }
    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }
  method condicionDeSalida() = 5
  
}


object nivel1D{
  const elementosNivel = [] 

  method iniciar(){    
    const enemigo1 = new Firewall(position = game.at(6,4))
    const archivo1 = new Archivo(position = game.at(5,5))
    elementosNivel.addAll([enemigo1,armadura,archivo1,puertaSalida,jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)}) 

    
    game.onTick(1000, 'movimiento', {enemigo1.mover()})

}

    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }
  method condicionDeSalida() = 1
}
object nivel2D{
  const elementosNivel = [] 

  method iniciar(){    
    const enemigo1 = new Firewall(position = game.at(6,4))
    const archivo1 = new Archivo(position = game.at(5,5))
    elementosNivel.addAll([enemigo1,armadura,archivo1,puertaSalida,jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)}) 

    
    game.onTick(1000, 'movimiento', {enemigo1.mover()})

}

    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }
  method condicionDeSalida() = 1
}
object nivel3D{
  const elementosNivel = [] 

  method iniciar(){    
    const enemigo1 = new Firewall(position = game.at(6,4))
    const archivo1 = new Archivo(position = game.at(5,5))
    elementosNivel.addAll([enemigo1,armadura,archivo1,puertaSalida,jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)}) 

    
    game.onTick(1000, 'movimiento', {enemigo1.mover()})

}

    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }
  method condicionDeSalida() = 1
}
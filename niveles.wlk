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
    const musicaJuego = game.sound("musica-juego.mp3")
    var property dificil = false
    
    method posicionAleatoria()= game.at((0..game.width()-1).anyOne(),(0..game.height()-1).anyOne())

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

    method obtenerNivelActual() = listaNiveles.get(nivelActual)
     
    method condicionDeSalida() = listaNiveles.get(nivelActual).condicionDeSalida()

    method condicionDeSalidaDificil() = listaNivelesDificiles.get(nivelActual).condicionDeSalida() && temporizador.segundos()>0

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

/*
    method reiniciarNivel(){              //--- Metodo innecesario
        listaNiveles.get(nivelActual).removerTodo()
        jugador.position(game.origin())
        jugador.restaurarEnergia()
        jugador.limpiarArchivos()   
        jugador.resistencia(1)
        //game.addVisual(jugador) 
        listaNiveles.get(nivelActual).iniciar() 
        //game.say(jugador, 'Nivel Reiniciado!')        
    }*/

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


    method reiniciar(){
      listaNiveles.get(nivelActual).removerTodo()
      game.addVisual(gameOver)
      keyboard.space().onPressDo{
      self.reinicioDeJuego()
      game.removeVisual(gameOver)}
    }

     method reiniciarDificil(){
      listaNivelesDificiles.get(nivelActual).removerTodo()
      game.addVisual(gameOver)
      keyboard.space().onPressDo{
      self.dificil(false)  
      self.reinicioDeJuego()
      game.removeVisual(gameOver)}        
      
    }


}

object pantallaInstrucciones{

    var property position = game.origin()
    method image() = 'instruccionesfinal.jpg'
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
  const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const archivo1 = new Archivo(position = escenario.posicionAleatoria())
    const archivo2 = new Archivo(position = escenario.posicionAleatoria())
    const archivo3 = new Archivo(position = escenario.posicionAleatoria())  
    const ob1 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob2 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob3 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob4 = new Obstaculo(position = escenario.posicionAleatoria())
  method agregarTodos(unaLista) = elementosNivel.addAll(unaLista) 

  method detenerEnemigosTemporalmente() {
    game.removeTickEvent('movimiento')
    game.schedule(2500, {game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover()})})
  }
  method iniciar(){
    
    self.agregarTodos([enemigo1,enemigo2,enemigo3,archivo1,archivo2,archivo3,puertaSalida, 
                        recargaEnergia,relojCibernetico,armadura,jugador,indicadorEnergia,indicadorDatos, ob1, ob2, ob3, ob4])

    elementosNivel.forEach({e => game.addVisual(e)})

    
      
   game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
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
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const enemigo4 = new VigilanteIDS(position = game.at(2,2)) 
    const archivo1 = new Archivo(position = escenario.posicionAleatoria())
    const archivo2 = new Archivo(position = escenario.posicionAleatoria())
    const archivo3 = new Archivo(position = escenario.posicionAleatoria())
    const archivo4 = new Archivo(position = escenario.posicionAleatoria())
    const ob1 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob2 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob3 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob4 = new Obstaculo(position = escenario.posicionAleatoria())
    method agregarTodos(unaLista) = elementosNivel.addAll(unaLista) 
    
    method detenerEnemigosTemporalmente() {
    game.removeTickEvent('movimiento')
    game.schedule(2500, {game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover()})})
  }
    method iniciar(){     
    self.agregarTodos([enemigo1,enemigo2,enemigo3,enemigo4,archivo1,archivo2,archivo3,archivo4,armadura,puertaSalida, 
                        jugador,relojCibernetico,indicadorEnergia,indicadorDatos,ob1,ob2,ob3,ob4])

    elementosNivel.forEach({e => game.addVisual(e)})
    
   game.onTick(750, 'movimiento', {enemigo2.mover();enemigo1.mover();
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
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const enemigo4 = new VigilanteIDS(position = game.at(2,2)) 
    const enemigo5 = new Firewall(position = game.at(4,6))
    const archivo1 = new Archivo(position = escenario.posicionAleatoria())
    const archivo2 = new Archivo(position = escenario.posicionAleatoria())
    const archivo3 = new Archivo(position = escenario.posicionAleatoria())
    const archivo4 = new Archivo(position = escenario.posicionAleatoria())
    const archivo5 = new Archivo(position = escenario.posicionAleatoria())
    const ob1 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob2 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob3 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob4 = new Obstaculo(position = escenario.posicionAleatoria())

    method agregarTodos(unaLista) = elementosNivel.addAll(unaLista) 

    method detenerEnemigosTemporalmente() {
    game.removeTickEvent('movimiento')
    game.schedule(2500, {game.onTick(1000, 'movimiento', {enemigo2.mover();enemigo1.mover();
        enemigo3.mover()})})
  }

    method iniciar(){    
    self.agregarTodos([enemigo1,enemigo2,enemigo3,enemigo4,enemigo5,armadura,ob1,ob2,ob3,ob4, 
                     archivo1,archivo2,archivo3,archivo4,archivo5,relojCibernetico,puertaSalida,jugador,indicadorEnergia,indicadorDatos])

    elementosNivel.forEach({e => game.addVisual(e)}) 
   
    game.onTick(500, 'movimiento', {enemigo2.mover();enemigo1.mover();
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
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const archivo1 = new Archivo(position = escenario.posicionAleatoria())
    const archivo2 = new Archivo(position = escenario.posicionAleatoria())
    const archivo3 = new Archivo(position = escenario.posicionAleatoria())  
    const ob1 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob2 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob3 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob4 = new Obstaculo(position = escenario.posicionAleatoria())

    elementosNivel.addAll([ enemigo1,enemigo2,enemigo3,archivo1,archivo2,archivo3,ob1,ob2,ob3,ob4,
                            jugador,temporizador,puertaSalida,indicadorDatos,indicadorEnergia,recargaEnergia])

    elementosNivel.forEach({e => game.addVisual(e)}) 
    temporizador.reiniciar()
    temporizador.iniciar()

    game.onTick(500, 'movimiento', {enemigo1.mover();enemigo2.mover();enemigo3.mover()}) 
 

}

    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }

  method condicionDeSalida() = 3
}
object nivel2D{
  const elementosNivel = [] 

  method iniciar(){    
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const enemigo4 = new VigilanteIDS(position = game.at(2,2)) 
    const archivo1 = new Archivo(position = escenario.posicionAleatoria())
    const archivo2 = new Archivo(position = escenario.posicionAleatoria())
    const archivo3 = new Archivo(position = escenario.posicionAleatoria())
    const archivo4 = new Archivo(position = escenario.posicionAleatoria())
    const ob1 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob2 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob3 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob4 = new Obstaculo(position = escenario.posicionAleatoria())
    elementosNivel.addAll([enemigo1,enemigo2,enemigo3,enemigo4,archivo1,archivo2,archivo3,archivo4,ob1,ob2,ob3,ob4,
                            jugador,temporizador,puertaSalida,indicadorDatos,indicadorEnergia, recargaEnergia])

    elementosNivel.forEach({e => game.addVisual(e)}) 
    temporizador.reiniciar()
    temporizador.iniciar()

    
    game.onTick(500, 'movimiento', {enemigo1.mover();enemigo2.mover();enemigo3.mver();enemigo4.mover()})

}

    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }
  method condicionDeSalida() = 4
}
object nivel3D{
  const elementosNivel = [] 

  method iniciar(){    
    const enemigo1 = new Firewall(position = game.at(6,4))
    const enemigo2 = new IATraidora(position = game.at(4,1))
    const enemigo3 = new RobotAntivirus(position = game.at(6,6))
    const enemigo4 = new VigilanteIDS(position = game.at(2,2)) 
    const enemigo5 = new Firewall(position = game.at(4,6))
    const archivo1 = new Archivo(position = escenario.posicionAleatoria())
    const archivo2 = new Archivo(position = escenario.posicionAleatoria())
    const archivo3 = new Archivo(position = escenario.posicionAleatoria())
    const archivo4 = new Archivo(position = escenario.posicionAleatoria())
    const archivo5 = new Archivo(position = escenario.posicionAleatoria())
    const ob1 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob2 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob3 = new Obstaculo(position = escenario.posicionAleatoria())
    const ob4 = new Obstaculo(position = escenario.posicionAleatoria())
    elementosNivel.addAll([enemigo1,enemigo2,enemigo3,enemigo4,enemigo5,archivo1,archivo2,archivo3,archivo4,archivo5,
                           ob1,ob2,ob3,ob4,jugador,temporizador,puertaSalida,indicadorDatos,indicadorEnergia,recargaEnergia])

    elementosNivel.forEach({e => game.addVisual(e)}) 
    temporizador.reiniciar()
    temporizador.iniciar()

    
    game.onTick(500, 'movimiento', {enemigo1.mover();enemigo2.mover();enemigo3.mover();enemigo4.mover();enemigo5.mover()})

}

    method removerTodo(){
    elementosNivel.forEach({e => game.removeVisual(e)})
    elementosNivel.clear()
  }
  method condicionDeSalida() = 5
}
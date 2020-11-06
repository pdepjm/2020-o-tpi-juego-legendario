
import wollok.game.*
import jugadores.*
import cartas.*


object ronda{
	const quienJuega = [jugador, jugador2]
	var elQueEstabaJugando
	
	method elQueLeToca(){
		return quienJuega.first()	
	}
	
	method pasarTurno(){
		elQueEstabaJugando = quienJuega.first()
		quienJuega.remove(quienJuega.first())
		quienJuega.add(elQueEstabaJugando)
		self.elQueLeToca().juga()	
	}	
	
	method seguirJugando(){
		quienJuega.first().juga()
	}
	
	method comenzarJuego(){
		mazo.cargaPalos()
		mazo.repartirCartas(jugador)
		mazo.repartirCartas(jugador2)
		marcadorJugador.mostrate()
		marcadorMaquina.mostrate()		
	}
	
	method posicionEnMesa(){
		quienJuega.first().tomaPosicion(game.at(17,2))
		quienJuega.last().tomaPosicion(game.at(17,12))
	}
	
	method asignaContrincantes(){
		quienJuega.first().contrincante(quienJuega.last())
		quienJuega.last().contrincante(quienJuega.first()) 
	}
}

object marcadorJugador{
	var property numPunto = 0
	
	method mostrate(){game.addVisual(self)}
	
	method position()= game.at(35,2)
	
	method image() = "punto"+numPunto+".png" 
}

object marcadorMaquina{
	var property numPunto = 0
	
	method mostrate(){game.addVisual(self)}
	
	method position()= game.at(35,15)
	
	method image() = "punto"+numPunto+".png"	
}

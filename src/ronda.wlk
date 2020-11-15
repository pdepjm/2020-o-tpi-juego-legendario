
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
		self.mostrarMarcadores(quienJuega)	
	}
	
	method mostrarMarcadores(jugadores){
			jugadores.forEach{unJugador=>unJugador.mostraPuntosEnVisual()}
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

class Marcador{
	var property posicion = game.at(35,2)
	var property numPunto = 0
	
	method position()= posicion 
	
	method mostrate(){game.addVisual(self)}
	
	method image() = "punto"+numPunto+".png"
}

class Error{
	var property posicion = game.at(25,9)
	method position() = posicion
	
	method mostrate(){game.addVisual(self)}
	method image() = "error.png"	
}


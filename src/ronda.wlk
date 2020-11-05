//import wollok.game.*
//import jugadores.*
//import cartas.*
//
//
//object ronda{
//	const quienJuega = [jugador, jugador2]
//	var elQueEstabaJugando
//	//var elQueJuega
//	
//	method elQueLeToca(){
//		return quienJuega.first()
//		
//	}
//	
//	method pasarTurno(){
//		elQueEstabaJugando = quienJuega.first()
//		quienJuega.remove(quienJuega.first())
//		quienJuega.add(elQueEstabaJugando)
//		self.elQueLeToca().pedirCartas()
//			
//	}	
//	
//	method seguirJugando(){
//		quienJuega.first().pedirCartas()
//	}
//	
//	method comenzarJuego(){
//		mazo.repartilesCartas(quienJuega)	//la ronda le delega al mazo que reparta las cartas a los jugadores que juegan
////		self.jugadoresPresentarse()
//		//self.asignaContrincantes()
//	}
//	
//	method jugadoresPresentarse(){
//		self.tomenSuPosicion()
//		
////		self.ocultaTusCartas(quienJuega.last())
//	}
//	
////	method ocultaTusCartas(contrincante){
////		contrincante.
////	}
//	
//	method tomenSuPosicion(){
////		self.configurenCartasJugadores()
//		self.posicionEnMesa()
//	}
//	
////	method configurenCartasJugadores(){
////		self.dameJugadorPpal().mostraFrenteCartas()
////	}
//	
////	method dameJugadorPpal() = quienJuega.first()
//	
//	method posicionEnMesa(){
//		quienJuega.first().tomaPosicion(game.at(17,2))
//		quienJuega.last().tomaPosicion(game.at(17,12))
//	}
//	
//	method asignaContrincantes(){
//		quienJuega.first().contrincante(quienJuega.last())
//		quienJuega.last().contrincante(quienJuega.first()) 
//	}
//}

import wollok.game.*
import jugadores.*
import cartas.*


object ronda{
	const quienJuega = [jugador, jugador2]
	var elQueEstabaJugando
	//var elQueJuega
	
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
	}
	
	method jugadoresPresentarse(){
		self.tomenSuPosicion()
		
//		self.ocultaTusCartas(quienJuega.last())
	}
	
//	method ocultaTusCartas(contrincante){
//		contrincante.
//	}
	
	method tomenSuPosicion(){
//		self.configurenCartasJugadores()
		self.posicionEnMesa()
	}
	
//	method configurenCartasJugadores(){
//		self.dameJugadorPpal().mostraFrenteCartas()
//	}
	
//	method dameJugadorPpal() = quienJuega.first()
	
	method posicionEnMesa(){
		quienJuega.first().tomaPosicion(game.at(17,2))
		quienJuega.last().tomaPosicion(game.at(17,12))
	}
	
	method asignaContrincantes(){
		quienJuega.first().contrincante(quienJuega.last())
		quienJuega.last().contrincante(quienJuega.first()) 
	}
}

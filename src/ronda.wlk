
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

object reglasLocas{
	
	method evaluarReglasLocas(elQJuega,carta){
		self.reglaLoca1(elQJuega,carta)
		self.reglaLoca2(elQJuega,carta)
		self.reglaLoca3(elQJuega,carta)
	}
	
	method reglaLoca1(elQJuega,carta){
		if (carta.decimeTuNum() == 1){
			elQJuega.sumarPunto()
		}
	}
	
	method reglaLoca2(elQJuega, carta){
		if(carta.decimeTuNum() == 2){
			elQJuega.irAPescar()
		}
	}
	
	method reglaLoca3(elQJuega, carta){
		if(carta.decimeTuNum() == 3){
			elQJuega.sumarPunto()
			elQJuega.sumarPunto()
		}
	}	
	
}
class Marcador{
	var property posicion = game.at(35,4)
	var property numPunto = 0
	
	method position()= posicion 
	
	method mostrate(){game.addVisual(self)}
	
	method image() = "punto"+numPunto+".png"
}




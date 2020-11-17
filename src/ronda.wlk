
import wollok.game.*
import jugadores.*
import cartas.*


object ronda{
	const quienJuega = [usuario, bot]
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
		mazo.repartirCartas(usuario)
		mazo.repartirCartas(bot)
		self.asignaOponentes()
		self.mostrarMarcadores(quienJuega)	
	}
	
	method mostrarMarcadores(jugadores){
			jugadores.forEach{unJugador=>unJugador.mostraPuntosEnVisual()}
	}			
	
	method posicionEnMesa(){
		quienJuega.first().tomaPosicion(game.at(14,2))
		quienJuega.last().tomaPosicion(game.at(14,12))
	}
	
	method asignaOponentes(){
		quienJuega.first().oponente(quienJuega.last())
		quienJuega.last().oponente(quienJuega.first()) 
	}
}

object reglasLocas{
	const property reglas = [doblePunto,pescasDNuevo,masUnPunto]
	
	method evaluarReglasLocas(elQJuega,carta){
		reglas.forEach{regla => regla.haceTuMagia(elQJuega,carta)}
	}	
}

object doblePunto{
	method haceTuMagia(elQJuega, carta){
		if(carta.decimeTuNum() == 3){
			elQJuega.sumarPunto()
			elQJuega.sumarPunto()
		}
	}	
}

object pescasDNuevo{
	method haceTuMagia(elQJuega, carta){
		if(carta.decimeTuNum() == 2){
			elQJuega.irAPescar()
		}
	}
}

object masUnPunto{
	method haceTuMagia(elQJuega,carta){
		if (carta.decimeTuNum() == 1){
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




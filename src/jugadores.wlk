import wollok.game.*
import cartas.*
import ronda.*

object jugador {

	var property cantPuntos = 0
	const property cartasJugador = []
	var property posicion = game.origin()
	var lista = #{}
	
	method mostraFrenteCartas(){
		cartasJugador.forEach{carta=>carta.esCartaJugador(true)}
	}

	method tomaPosicion(unaPosicion){
		cartasJugador.forEach{carta=>carta.posicion(unaPosicion)}
	}

	method acomodarCartas() {
		var incrementador = 1
		cartasJugador.forEach{ carta =>
			carta.posicion(carta.position().right(incrementador))
		;incrementador++
		}
	}

	method mostrarCartasEnMesa() {
		cartasJugador.forEach{ carta => game.addVisual(carta)}
	}

	method paloCartas() = cartasJugador.map({ cartita => cartita.decimeTuPalo() }) // decime tu palo y num para ver 

	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() }) // que cartas tienen los jugadores

	method sumarPunto() {
		cantPuntos += 1
	}

	method recibirCarta(cartasAgregadas) {
		cartasJugador.add(cartasAgregadas)
	}

	method cartasJugador() = cartasJugador

	method darCarta(cartaPedida) {
		cartasJugador.remove(cartaPedida)
	}

	// esta bien que el jugador diga tengo cuatro cartas iguales o tendria que la maquina darle un punto cuando ve que tiene 
	// cuatro cartas iguales
	method cuatroCartasIguales(numero) {
		lista = (self.cartasJugador()).filter{ unaCarta => unaCarta.mismoNumero(numero) }
		if (lista.sizeOf() == 4) {
			self.sumarPunto()
		}
	// que se pone 
	}

	method pedirCartas(unaCarta) {
		if ((jugador2.cartasJugador()).contains(unaCarta)) {
			self.recibirCarta(unaCarta)
			ronda.seguirJugando()
		} else {
			self.irAPescar()
			ronda.pasarTurno()
		}
	}

	method irAPescar() {
		mazo.darUnaCarta(self)
	}

}

object jugador2 {

	var property cantPuntos2 = 0
	var property cartasJugador = #{}
	var property posicion2 = game.origin()
	var lista2 = #{}
	
	method mostraFrenteCartas(){
		cartasJugador.forEach{carta=>carta.esCartaJugador(true)}
	}
	
	method tomaPosicion(unaPosicion){
		cartasJugador.forEach{carta=>carta.posicion(unaPosicion)}
	}
	
	method acomodarCartas() {
		var incrementador = 1
		cartasJugador.forEach{ carta =>
			carta.posicion(carta.position().right(incrementador))
		;incrementador++
		}
	}

	method mostrarCartasEnMesa() {
		cartasJugador.forEach{ carta => game.addVisual(carta)}
	}		

	method paloCartas() = cartasJugador.map({ cartita => cartita.decimeTuPalo() })

	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() })

	method sumarPunto() {
		cantPuntos2 += 1
	}

	method recibirCarta(cartasAgregadas) {
		cartasJugador.add(cartasAgregadas)
	}

	method cartasJugador() = cartasJugador

	method darCarta(cartaPedida) {
		cartasJugador.remove(cartaPedida)
	}

	method pedirCartas(unaCarta) {
		if ((jugador.cartasJugador()).contains(unaCarta)) {
			self.recibirCarta(unaCarta)
			ronda.seguirJugando()
		} else {
			self.irAPescar()
			ronda.pasarTurno()
		}
	}

	method irAPescar() {
		mazo.darUnaCarta(self)
	}

	method cuatroCartasIguales(numero) {
		lista2 = (self.cartasJugador()).filter{ unaCarta => unaCarta.mismoNumero(numero) }
		if (lista2.sizeOf() == 4) {
			self.sumarPunto()
		}
	// que se pone 
	}

}


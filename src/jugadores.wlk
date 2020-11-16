import wollok.game.*
import cartas.*
import ronda.*

class Jugador {

	var property cantPuntos = 0
	const property cartasJugador = []
	const marcador = new Marcador()
	var property oponente

	method darCarta(cartaPedida) {
		cartasJugador.remove(cartaPedida)
		cartasJugador.add(cartaPedida)
	}

	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() })

	method mostraPuntosEnVisual() {
		marcador.mostrate()
	}

	method sumarPunto() {
		cantPuntos = (cantPuntos + 1).min(4)
		marcador.numPunto(cantPuntos)
	}

	method sacaCartas(cartas) {
		cartas.forEach{ carta => cartasJugador.remove(carta)}
	}

	method cuatroCartasIguales(numero) {
		if ((self.cartasConMismoNum(numero)).size() == 4) {
			self.sumarPunto()
			self.sacameCartasVisual(self.cartasConMismoNum(numero))
			self.sacaCartas(self.cartasConMismoNum(numero))
		}
	}

	method sacameCartasVisual(cartas) {
		cartas.map{ carta => game.removeVisual(carta)}
	}

	method finPartida() {
		if (self.cantPuntos() == 4) {
			throw new Exception(message = "JUEGO TERMINADO SOS UN GANADOR")
		}
	}

	method tenesEsteNum(unNumero) = (cartasJugador.map({ carta => carta.decimeTuNum() })).contains(unNumero)

	method cartasConMismoNum(unNumero) = cartasJugador.filter({ carta => carta.esPareja(unNumero) })

	method recibirCartaMazo(carta) {
		mazo.sacarCarta(carta)
		cartasJugador.add(carta)
		self.configuraCarta(carta)
		self.mostrarCartaEnMesa(carta)
	}

	method configuraCarta(carta) {
		carta.esCartaJugador(true)
		carta.posicion(game.at(11, 2))
		self.acomodarCartaEnMesa(carta)
	}

	method recibirCartaJugador(carta) {
		cartasJugador.add(carta)
		self.configuraCarta(carta)
	}

	method acomodarCartaEnMesa(carta) {
		carta.posicion(carta.position().right(self.cartasJugador().size() + 1))
	}

	method mostrarCartaEnMesa(unaCarta) {
		game.addVisual(unaCarta)
	}

	method agregarCartaJugador(carta) {
		cartasJugador.add(carta)
	}

	method darCartaJugador(cartaPedida) {
		self.sacarCarta(cartaPedida)
		oponente.recibirCartaJugador(cartaPedida)
	}

	method sacarCarta(carta) {
		cartasJugador.remove(carta)
	}

	method irAPescar() {
		mazo.darUnaCarta(self)
	}
	
	method dameCartas(cartas) {
		cartas.forEach{ carta => oponente.darCartaJugador(carta)}
	}
	
	method dameCartasConEseNum(unNumero) {
		self.dameCartas(oponente.cartasConMismoNum(unNumero))
	}
	
	method pedirNum(unNumero) {
		if (oponente.tenesEsteNum(unNumero)) {
			self.dameCartasConEseNum(unNumero)
			self.finPartida()
			ronda.seguirJugando()
		} else {
			self.irAPescar()
			reglasLocas.evaluarReglasLocas(self, cartasJugador.last())
			self.finPartida()
			ronda.pasarTurno()
		}
		self.cuatroCartasIguales(cartasJugador.last().decimeTuNum())
	}

}

object usuario inherits Jugador {

	override method pedirNum(unNumero) {
		if (!self.tenesEsteNum(unNumero)) {
			self.error("NO PODES PEDIR EL " + unNumero)
			ronda.seguirJugando()
		}
		super(unNumero)
		super(cartasJugador.last().decimeTuNum())		
	}
	
	method juga(){
	}
}

object bot inherits Jugador {

	method tomaCualquiera() = cartasJugador.map({ carta => carta.decimeTuNum() }).anyOne()

	method juga() {
		self.pedirNum(self.tomaCualquiera())
	}

	override method configuraCarta(unaCarta) {
		unaCarta.posicion(game.at(11, 12))
		self.acomodarCartaEnMesa(unaCarta)
	}

	override method mostraPuntosEnVisual() {
		marcador.posicion(game.at(35, 15))
		super()
	}
}


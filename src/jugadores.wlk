import wollok.game.*
import cartas.*
import ronda.*

class Jugador {

	var property cantPuntos = 0
	const property cartasJugador = []
	const marcador
	var property oponente
	var nombre
	var posicion
	const esJugador
	const property posicionCartaBase
	
	method mostrarVisual() {
		game.addVisual(self)
	}

	method position() = posicion

	method image() = "img" + nombre + ".png"

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
			game.say(self, "tengo cuatro " + numero)
			self.sumarPunto()
			self.sacameCartasVisual(self.cartasConMismoNum(numero))
			self.sacaCartas(self.cartasConMismoNum(numero))
		}
	}

	method sacameCartasVisual(cartas) {
		cartas.forEach{ carta => game.removeVisual(carta)}
	}

	method finPartida() {
		if (self.cantPuntos() == 4) {
			self.error("LISTO GANE")
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
		carta.esCartaJugador(esJugador)
		self.acomodarCartaEnMesa(carta)
	}

	method recibirCartaJugador(carta) {
		cartasJugador.add(carta)
		self.configuraCarta(carta)
	}

	method acomodarCartaEnMesa(carta) {
		carta.posicion(posicionCartaBase.right(self.cartasJugador().size() + 1))
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
			self.cuatroCartasIguales(unNumero)
			self.finPartida()
			ronda.seguirJugando()
		} else {
			game.say(oponente,"No, GO FISH")
			self.irAPescar()
			reglasLocas.evaluarReglasLocas(self, cartasJugador.last())
			self.cuatroCartasIguales(cartasJugador.last().decimeTuNum())
			self.finPartida()
			ronda.pasarTurno()
		}
	}

}

object usuario inherits Jugador(posicionCartaBase=game.at(13,1),marcador=new Marcador(posicion=game.at(36, 4)),nombre="usuario",posicion=game.at(11, 5),esJugador=true) {

	override method pedirNum(unNumero) {
		if (!self.tenesEsteNum(unNumero)) {
			self.error("NO PODES PEDIR EL " + unNumero)
		}
		super(unNumero)
	}

	method juga() {
	}

}

object bot inherits Jugador(posicionCartaBase=game.at(13,13), marcador = new Marcador(posicion = game.at(36, 15)),nombre="bot",posicion=game.at(11, 15),esJugador=false) {

	method tomaCualquiera() = cartasJugador.map({ carta => carta.decimeTuNum() }).anyOne()

	method juga() {
		game.onTick(4000, "pensando", { self.pedirNum(self.tomaCualquiera())})
	}

	override method pedirNum(numero) {
		game.say(self, "¿ tenes el " + numero + " ?")
		game.removeTickEvent("pensando")
		super(numero)
	}

}


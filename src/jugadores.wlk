import wollok.game.*
import cartas.*
import ronda.*

class Jugador {
	var nombre
	var property cantPuntos = 0
	const property cartasJugador = []
	const marcador = new Marcador()
	var property oponente
	var posicion
	
	method mostrarVisual(){
		game.addVisual(self)
	}

	method position() = posicion
	
	method image() = "img"+nombre+".png"

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



	method cuatroCartasIguales(numero) {
		if (self.tengoCuatroDelMismo(numero)) {
//			game.say(self,"tenes cuatro "+numero)
			self.sumarPunto()
			self.sacameCartasVisual(numero)
			self.sacaCartas(numero)
		}
	}

	method tengoCuatroDelMismo(numero) = (self.cartasConMismoNum(numero)).size() == 4

	method sacameCartasVisual(numero) {
		self.cartasConMismoNum(numero).forEach{ carta => game.removeVisual(carta)}
	}
	
	method sacaCartas(numero) {
		self.cartasConMismoNum(numero).forEach{ carta => cartasJugador.remove(carta)}
	}

	method finPartida() {
		if (self.cantPuntos() == 8) {
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
		carta.posicion(game.at(11, 1))
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
	
	method pedirNum(unNumero){
		if (oponente.tenesEsteNum(unNumero)) {
			self.dameCartasConEseNum(unNumero)
			self.cuatroCartasIguales(unNumero)
			self.finPartida()
			ronda.seguirJugando()
		} else {
			game.say(oponente,"No, GO FISH")
			self.irAPescar()			
			reglasLocas.evaluarReglasLocas(self, cartasJugador.last())
			self.cuatroCartasIguales(unNumero)
			self.finPartida()
			ronda.pasarTurno()
		}
	}
}

object usuario inherits Jugador(nombre="usuario",posicion=game.at(8,5)) {

	override method pedirNum(unNumero) {
		if (!self.tenesEsteNum(unNumero)) {
			self.error("NO PODES PEDIR EL " + unNumero)
//			ronda.seguirJugando()
		}
		super(unNumero)
	}
	
	method juga(){
	}
}

object bot inherits Jugador(nombre="bot",posicion=game.at(8,15)) {

	method tomaCualquiera() = cartasJugador.map({ carta => carta.decimeTuNum() }).anyOne()

	method juga() {
		game.onTick(8000,"pensando",{self.pedirNum(self.tomaCualquiera())})
	}

	override method configuraCarta(unaCarta) {
		unaCarta.esCartaJugador(true)
		unaCarta.posicion(game.at(11, 13))
		self.acomodarCartaEnMesa(unaCarta)
	}

	override method mostraPuntosEnVisual() {
		marcador.posicion(game.at(35, 15))
		super()
	}
	
	override method pedirNum(numero){
		game.say(self,"¿tenes el "+numero)
		game.removeTickEvent("pensando")
		super(numero)
	}
}


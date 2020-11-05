import wollok.game.*
import cartas.*
import ronda.*



object jugador {

	var property cantPuntos = 0
	const property cartasJugador = []
	var property posicion = game.origin()

	

	
	method paloCartas() = cartasJugador.map({ cartita => cartita.decimeTuPalo() }) 
	
	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() }) 

	method sumarPunto() {
		cantPuntos += 1
	}

	method cartasJugador() = cartasJugador

	method darCarta(cartaPedida) {
		cartasJugador.remove(cartaPedida)
		cartasJugador.add(cartaPedida)
	}
	
	method sacaCartas(cartas){
		cartas.forEach{carta => cartasJugador.remove(carta)}
	}
	
	method juga(){}
	
	method cuatroCartasIguales(numero) {
		if ((self.cartasConMismoNum(numero)).size() == 4){ 
			self.sumarPunto()
			self.sacaCartas(self.cartasConMismoNum(numero))
			game.removeVisual(self.cartasConMismoNum(numero))
			
		}	
	}
	
	method pedirNum(unNumero){
		self.cuatroCartasIguales(unNumero)
		if(jugador2.tenesEsteNum(unNumero)){
			self.dameCartasConEseNum(unNumero)	
			self.finPartida()
			ronda.seguirJugando()
		} else {
			self.irAPescar()
			self.juli(cartasJugador.last())
			self.finPartida()
			ronda.pasarTurno()
		  }
		self.cuatroCartasIguales(cartasJugador.last().decimeTuNum())  
	}
	
	method finPartida(){
		if(self.cantPuntos() == 1){
			throw new Exception(message = "JUEGO TERMINADO SOS UN GANADOR") 
		}}
	
	method tenesEsteNum(unNumero) = (cartasJugador.map({carta=>carta.decimeTuNum()})).contains(unNumero)
	
	method dameCartasConEseNum(unNumero){ 
		self.dameCartas(jugador2.cartasConMismoNum(unNumero))
	}
		
	method cartasConMismoNum(unNumero) = cartasJugador.filter({carta=>carta.esPareja(unNumero)})
	
	method dameCartas(cartas){
		cartas.forEach{carta=>jugador2.darCartaJugador(carta)}
	}

	method recibirCartaMazo(carta) {
		mazo.sacarCarta(carta)
		cartasJugador.add(carta)		
		self.configuraCarta(carta)
		self.mostrarCartaEnMesa(carta)
	}
	
	method juli(carta){
		if (carta.decimeTuNum() == 1){
			self.sumarPunto()
		}
	}
	
	method recibirCartaJugador(carta){
		cartasJugador.add(carta)
		self.configuraCarta(carta)
	}
	
	method configuraCarta(carta) {
		carta.esCartaJugador(true)
		carta.posicion(game.at(17,2))
		self.acomodarCartaEnMesa(carta)
		//
	}
	
	method acomodarCartaEnMesa(carta) {
		carta.posicion(carta.position().right(self.cartasJugador().size() + 1))
	}
	
	method mostrarCartaEnMesa(unaCarta) {
		game.addVisual(unaCarta)
	}
	
	method agregarCartaJugador(carta){
		cartasJugador.add(carta)
	}	

	method darCartaJugador(cartaPedida) {
		self.sacarCarta(cartaPedida)
		jugador2.recibirCartaJugador(cartaPedida)	
	}	
	
	method sacarCarta(carta){
		cartasJugador.remove(carta)
	}
	
	method irAPescar() {
		mazo.darUnaCarta(self)
	}

}

object jugador2 {

	var property cantPuntos2 = 0
	var property cartasJugador = []
	var property posicion2 = game.origin()
	var property numRandom = {numRandom = self.tomaCualquiera()}
		
	method paloCartas() = cartasJugador.map({ cartita => cartita.decimeTuPalo() })

	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() })

	method sumarPunto() {
		cantPuntos2 += 1
	}
	
	method tomaCualquiera() = cartasJugador.map({carta => carta.decimeTuNum()}).anyOne()	
	
	method sacaCartas(cartas){
		cartas.forEach{carta => cartasJugador.remove(carta)}
	}
	
	method juga(){
		numRandom.apply()
		self.pedirNum(numRandom)
	}
	
	method cuatroCartasIguales(numero) {
		if ((self.cartasConMismoNum(numero)).size() == 4) {
			self.sumarPunto()
			self.sacaCartas(self.cartasConMismoNum(numero))
			self.sacameCartasVisual(self.cartasConMismoNum(numero))
			
		}
	}
	
	method sacameCartasVisual(cartas){
		cartas.forEach{carta => game.removeVisual(carta)}
	}
	
	method juli(carta){
		if(carta.decimeTuNum() == 1){
			self.irAPescar()
		}
	}
	
	method pedirNum(unNumero){
		self.cuatroCartasIguales(unNumero)
		if(jugador.tenesEsteNum(unNumero)){
			self.dameCartasConEseNum(unNumero)
			//ronda.seguirJugando()
		} else {
			self.irAPescar()
			self.juli(cartasJugador.last())
			//ronda.pasarTurno()
		  }
		self.cuatroCartasIguales(cartasJugador.last().decimeTuNum())
		self.numRandom({numRandom = self.tomaCualquiera()}) 
	}	
	
	method tenesEsteNum(unNumero) = (cartasJugador.map({carta=>carta.decimeTuNum()})).contains(unNumero)
	
	method dameCartasConEseNum(unNumero){ 
		self.dameCartas(jugador.cartasConMismoNum(unNumero))
	}
	
	method cartasConMismoNum(unNumero) = cartasJugador.filter({carta=>carta.esPareja(unNumero)})
	
	method dameCartas(cartas){
		cartas.forEach{carta=>jugador.darCartaJugador(carta)}
	}

	method recibirCartaMazo(carta) {
		mazo.sacarCarta(carta)
		cartasJugador.add(carta)
		self.configuraCarta(carta)
		self.mostrarCartaEnMesa(carta)
		if (carta.decimeTuNum() == 1){
			self.sumarPunto()
		}
	}
	
	method recibirCartaJugador(carta){
		cartasJugador.add(carta)
		self.configuraCarta(carta)
	}
	
	method configuraCarta(unaCarta) {
		unaCarta.esCartaJugador(false)
		unaCarta.posicion(game.at(17,12))
		self.acomodarCartaEnMesa(unaCarta)
	}
	
	method acomodarCartaEnMesa(unaCarta) {
		unaCarta.posicion(unaCarta.position().right(self.cartasJugador().size() + 1))
	}	

	method mostrarCartaEnMesa(unaCarta) {
		game.addVisual(unaCarta)
	}
	
	method agregarCartaJugador(carta){
		cartasJugador.add(carta)
	}

	method cartasJugador() = cartasJugador

	method darCartaJugador(cartaPedida) {
		self.sacarCarta(cartaPedida)
		jugador.recibirCartaJugador(cartaPedida)
	}
	
	method sacarCarta(carta){
		cartasJugador.remove(carta)
	}

	method irAPescar() {
		mazo.darUnaCarta(self)
	}
}

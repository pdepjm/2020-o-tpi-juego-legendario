import wollok.game.*
import cartas.*
import ronda.*



object jugador {

	var property cantPuntos = 0
	const property cartasJugador = []
	var property posicion = game.origin()
//	var lista 

	method paloCartas() = cartasJugador.map({ cartita => cartita.decimeTuPalo() }) // decime tu palo y num para ver 

	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() }) // que cartas tienen los jugadores

	method sumarPunto() {
		cantPuntos += 1
	}

	method cartasJugador() = cartasJugador

	method darCarta(cartaPedida) {
		cartasJugador.remove(cartaPedida)
		cartasJugador.add(cartaPedida)
	}

	method cuatroCartasIguales(numero) {
//		lista = (cartasJugador.filter{ unaCarta => unaCarta.esPareja(numero) })
		if (self.cartasConMismoNum(numero).size() == 4) 
			self.sumarPunto()
			self.sacaCartas(self.cartasConMismoNum(numero))
			//cartasJugador.remove(self.cartasConMismoNum(numero))	
	}
	
	method sacaCartas(cartas){
		cartas.forEach{carta => cartasJugador.remove(carta)}
	}

//	method juga(){
//		self.ped
//	}

	method pedirNum(unNumero){
		//self.cuatroCartasIguales()
		if(jugador2.tenesEsteNum(unNumero)){
			self.dameCartasConEseNum(unNumero)
			//ronda.seguirJugando()
		} else {
			self.irAPescar()
			//ronda.pasarTurno()
		  }
		self.cuatroCartasIguales(unNumero)  
	}
	
	method tenesEsteNum(unNumero) = (cartasJugador.map({carta=>carta.decimeTuNum()})).contains(unNumero)
	
	method dameCartasConEseNum(unNumero){ 
		self.dameCartas(jugador2.cartasConMismoNum(unNumero))
	}
			// OK
	method cartasConMismoNum(unNumero) = cartasJugador.filter({carta=>carta.esPareja(unNumero)})
	
	method dameCartas(cartas){//OK
		cartas.forEach{carta=>jugador2.darCartaJugador(carta)}
	}

	method recibirCartaMazo(carta) {
		mazo.sacarCarta(carta)
		cartasJugador.add(carta)
		self.configuraCarta(carta)
		self.mostrarCartaEnMesa(carta)
	}
	
	method recibirCartaJugador(carta){
		jugador2.sacarCarta(carta)
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
		jugador2.recibirCartaJugador(cartaPedida)
		//cartasJugador.remove(cartaPedida)
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
	var lista2 = #{}
//	var numRandom = self.tomaCualquiera()
		
	method paloCartas() = cartasJugador.map({ cartita => cartita.decimeTuPalo() })

	method numCartas() = cartasJugador.map({ unaCarta => unaCarta.decimeTuNum() })

	method sumarPunto() {
		cantPuntos2 += 1
	}
	
	method tomaCualquiera() = cartasJugador.map{carta => carta.decimeTuNum()}.anyOne()	
	
	
	
	method pedirNum(numerito){
		if(jugador.tenesEsteNum(numerito)){
			self.dameCartasConEseNum(numerito)
			//ronda.seguirJugando()
		} else {
			self.irAPescar()
			//ronda.pasarTurno()
		  }
	}	
	
	method tenesEsteNum(unNumero) = (cartasJugador.map({carta=>carta.decimeTuNum()})).contains(unNumero)
	
	method dameCartasConEseNum(unNumero){ 
		self.dameCartas(jugador.cartasConMismoNum(unNumero))
	}
	
	method cartasConMismoNum(unNumero) = cartasJugador.filter({carta=>carta.esPareja(unNumero)})
	
	method dameCartas(cartas){//OK
		cartas.forEach{carta=>jugador.darCartaJugador(carta)}
	}

	method recibirCartaMazo(carta) {
		mazo.sacarCarta(carta)
		cartasJugador.add(carta)
		self.configuraCarta(carta)
		self.mostrarCartaEnMesa(carta)
	}
	
	method recibirCartaJugador(carta){
		jugador.sacarCarta(carta)
		cartasJugador.add(carta)
		self.configuraCarta(carta)
	}
	
	method configuraCarta(unaCarta) {
		unaCarta.esCartaJugador(false)
		unaCarta.posicion(game.at(17,12))
		self.acomodarCartaEnMesa(unaCarta)
		//self.mostrarCartaEnMesa(unaCarta)
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
		jugador.recibirCartaJugador(cartaPedida)
		//cartasJugador.remove(cartaPedida)
	}
	
	method sacarCarta(carta){
		cartasJugador.remove(carta)
	}

	method irAPescar() {
		mazo.darUnaCarta(self)
	}

	method cuatroCartasIguales(numero) {
		lista2 = (self.cartasJugador()).filter{ unaCarta => unaCarta.mismoNumero(numero) }
		if (lista2.sizeOf() == 4) {
			self.sumarPunto()
		}
	}

}



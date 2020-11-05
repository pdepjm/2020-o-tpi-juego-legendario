import wollok.game.*
import jugadores.*
import ronda.*

object mazo {

	const property cartasMazo = []
	const palos = [ "basto", "oro", "copa", "espada" ]

	method position() = game.origin()

	method image() = "posterior.png"

	method paloCartas() = cartasMazo.map({ cartita => cartita.decimeTuPalo() }) // paloCartas y numCartas para ver que no se repitan

	method numCartas() = cartasMazo.map({ cartita => cartita.decimeTuNum() })

	method cargaPalos() {
		palos.forEach({ palo => self.creaTandaPalo(palo)})
	}

	method creaTandaPalo(unPalo) {
		(1..12).forEach{ value => cartasMazo.add(new Carta(palo = unPalo, num = value))}
	}

	method cartasEnMazo() = cartasMazo.size()

	method repartilesCartas(jugadores) {
		jugadores.forEach{ unJugador => self.repartirCartas(unJugador)} // agrego esta funcion que recibe los jugadores de ronda
	}

	method repartirCartas(unJugador) {
		new Range(start = 1, end = 7).forEach{ value => unJugador.recibirCartaMazo(cartasMazo.anyOne())}
		//cartasMazo.removeAll(unJugador.cartasJugador())
	}

	method sacarCarta(carta){
		cartasMazo.remove(carta)
	}
	
	method darUnaCarta(unJugador) {
		unJugador.recibirCartaMazo(cartasMazo.anyOne())
		//cartasMazo.removeAll(unJugador.cartasJugador()) // elimino la carta del mazo
	}

}

class Carta {

	var property posicion = game.center()
	var palo
	const num
	var property esCartaJugador = false

	method decimeTuPalo() = palo

	method decimeTuNum() = num

	method image() {
		return if (self.esCartaJugador())
		palo + num + ".png"
	else "posteriorCartaEnJuego.png"
	}

	method esCartaJugador() = esCartaJugador  

	method position() = posicion

	method esPareja(unNumero) = self.decimeTuNum() == unNumero 

	//method esPareja(otraCarta) = true

}

import wollok.game.*
import jugadores.*
import ronda.*

object mazo{

const property cartasMazo = []
const palos = ["basto","oro","copa","espada"]

method paloCartas() = cartasMazo.map({ cartita => cartita.decimeTuPalo() })	// paloCartas y numCartas para ver que no se repitan

method numCartas() = cartasMazo.map({ cartita => cartita.decimeTuNum() })

method cargaPalos(){
	palos.forEach({palo => self.creaTandaPalo(palo)})
}

method creaTandaPalo(unPalo){
	new Range(start = 1, end = 12).forEach { value => cartasMazo.add(new Carta(palo=unPalo,num=value))}
}

method cartasEnMazo() = cartasMazo.size()

method repartilesCartas(jugadores){
	jugadores.forEach{unJugador => self.repartirCartas(unJugador)}   //agrego esta funcion que recibe los jugadores de ronda
}

method repartirCartas(unJugador) {
	new Range(start = 1, end = 6).forEach{ value => unJugador.recibirCarta(cartasMazo.anyOne())}
	cartasMazo.removeAll(unJugador.cartasJugador())
}


method darUnaCarta(unJugador){
	unJugador.recibirCarta(cartasMazo.anyOne())
	cartasMazo.removeAll(unJugador.cartasJugador())	// elimino la carta del mazo
}

}


class Carta {
	//hay que csmbiar el corazon porque usamos cartas españolas 
	var palo 
	const num 
	
	method decimeTuPalo() = palo	

	method decimeTuNum() = num
	
	method num() = num
	
	method mismoNumero(numero) = num == numero 
	
	method palo() = palo
	
	method image() = palo+num+".png"
	
	method position() = true 
	
	method mostrate() = true
	
	method ocultar() = true
	
	method parejaAMesa(unaCarta) = true
	
	method aPescar() = true
	
	method esPareja(otraCarta) = true
}


object cartitaPrueba inherits Carta{

	override method position() = game.center()
	
}

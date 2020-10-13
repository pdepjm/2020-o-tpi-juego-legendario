import wollok.game.*
import jugadores.*

object mazo{

const property cartasMazo = #{}
const palos = ["basto","oro","copa","espada"]

//method cartas() = cartas

method cargaPalos(){
	palos.forEach({palo => self.creaTandaPalo(palo)})
}

method creaTandaPalo(unPalo){
	new Range(start = 1, end = 12).forEach { value => cartasMazo.add(new Carta(palo=unPalo,num=value))}
}

method cartasEnMazo() = cartasMazo.size()

method repartirCartas(){
	new Range(start = 1, end = 6).forEach { value => jugador.recibirCarta(cartasMazo.anyOne())}
	/**jugador.recibirCarta(cartasMazo.anyOne())
	jugador.recibirCarta(cartasMazo.anyOne())
	jugador.recibirCarta(cartasMazo.anyOne())
	jugador.recibirCarta(cartasMazo.anyOne())
	jugador.recibirCarta(cartasMazo.anyOne())
	jugador.recibirCarta(cartasMazo.anyOne())*/
	cartasMazo.removeAll(jugador.cartasJugador())
}

method darUnaCarta(){
	jugador.recibirCarta(cartasMazo.anyOne())
}

}


class Carta {
	//hay que csmbiar el corazon porque usamos cartas españolas 
	var palo = "corazon"
	const num = 1
	
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

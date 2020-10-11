import wollok.game.*

object mazo{

const cartas = #{}
const palos = ["corazon","pica","trebol","espada"]

method cartas() = cartas

method cargaPalos(){
	palos.forEach({palo => self.creaTandaPalo(palo)})
}

method creaTandaPalo(unPalo){
	new Range(start = 1, end = 13).forEach { value => cartas.add(new Carta(palo=unPalo,num=value))}
}

method cartasEnMazo() = cartas.size()

}


class Carta {
	var palo = "corazon"
	var num = 1
	
	method num() = num
	
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

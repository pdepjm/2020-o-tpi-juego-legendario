object mazo{

const lista = #{}
const palos = ["corazon","pica","trebol","espada"]

method lista() = lista

method cargaPalos(){
	palos.forEach({palo => self.creaTandaPalo(palo)})
}

method creaTandaPalo(unPalo){
	new Range(start = 1, end = 13).forEach { value => lista.add(new Carta(palo=unPalo,num=value))}
}

method cartasEnMazo() = lista.size()

}


class Carta {
	var palo
	var num
	
	method num() = num
	
	method image() = true
	
	method mostrate() = true
	
	method ocultar() = true
	
	method parejaAMesa(unaCarta) = true
	
	method aPescar() = true
	
	method esPareja(otraCarta) = true
}
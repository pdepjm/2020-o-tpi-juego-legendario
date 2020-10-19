import jugadores.*
import cartas.*


object ronda{
	const quienJuega = [jugador, jugador2]
	var elQueEstabaJugando
	//var elQueJuega
	
	method elQueLeToca(){
		return quienJuega.first()
		
	}
	
	method pasarTurno(){
		elQueEstabaJugando = quienJuega.first()
		quienJuega.remove(quienJuega.first())
		quienJuega.add(elQueEstabaJugando)
		self.elQueLeToca().pedirCartas()
			
	}	
	
	method seguirJugando(){
		quienJuega.first().pedirCartas()
	}
	
	method comenzarJuego(){
		mazo.repartilesCartas(quienJuega)	//la ronda le delega al mazo que reparta las cartas a los jugadores que juegan
		//self.asignaContrincantes()
	}
	
	method asignaContrincantes(){
		quienJuega.first().contrincante(quienJuega.last())
		quienJuega.last().contrincante(quienJuega.first()) 
	}
}


import jugadores.*
import cartas.*


object ronda{
	var quienJuega = [jugador, jugador2]
	var elQueEstabaJugando
	var elQueJuega
	
	method seguirJugando(){
		elQueJuega = quienJuega.first()
		
	}
	
	method pasarTurno(){
		elQueEstabaJugando = quienJuega.first()
		quienJuega.remove(quienJuega.first())
		quienJuega.add(elQueEstabaJugando)
		self.seguirJugando()
	}
}
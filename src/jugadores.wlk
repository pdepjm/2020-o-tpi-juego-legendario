
import wollok.game.*
import cartas.*
import ronda.*
	
object jugador{
	var property cantPuntos = 0
	var property cartasJugador = #{}
	var property posicion = game.origin()
	var lista = #{}
	
	method sumarPunto(){
		cantPuntos += 1	}
	
	method recibirCarta(cartasAgregadas){
		
		cartasJugador.add(cartasAgregadas)	
	}
	method cartasJugador() = cartasJugador
	
	
	method darCarta(cartaPedida){
		cartasJugador.remove(cartaPedida)
	}
	// esta bien que el jugador diga tengo cuatro cartas iguales o tendria que la maquina darle un punto cuando ve que tiene 
	// cuatro cartas iguales
	method cuatroCartasIguales(numero){
		lista = (self.cartasJugador()).filter{unaCarta => unaCarta.mismoNumero(numero)}
		if(lista.sizeOf() == 4){
			self.sumarPunto()
		}
		//que se pone 
	}
	
method pedirCartas(unaCarta){
		if((jugador2.cartasJugador2()).contains(unaCarta)){
		self.recibirCarta(unaCarta)
		}
		else{
			self.irAPescar()
			ronda.pasarTurno()
		}
	}
	
method irAPescar(){
		mazo.darUnaCarta()
	}
}

object jugador2{
	var property cantPuntos2 = 0
	var property cartasJugador2 = #{}
	var property posicion2 = game.origin()
	var lista2 = #{}
	
	method sumarPunto(){
		cantPuntos2 += 1	}
	
	method recibirCarta(cartasAgregadas){
		
		cartasJugador2.add(cartasAgregadas)	
	}
	method cartasJugador2() = cartasJugador2
	
	
	method darCarta(cartaPedida){
		cartasJugador2.remove(cartaPedida)
	}
	
method pedirCartas(unaCarta){
		if((jugador.cartasJugador()).contains(unaCarta)){
		self.recibirCarta(unaCarta)
		ronda.seguirJugando()
        }
		else{
			self.irAPescar()
			ronda.pasarTurno()
		}
			
	}
method irAPescar(){
		mazo.darUnaCarta()
	}
	
	method cuatroCartasIguales(numero){
		lista2 = (self.cartasJugador2()).filter{unaCarta => unaCarta.mismoNumero(numero)}
		if(lista2.sizeOf() == 4){
			self.sumarPunto()
		}
		//que se pone 
	}
}





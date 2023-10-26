class EnfermedadInfecciosa {
	var cantCelulasAmenazadas 
	
	method reproducirse(){
		cantCelulasAmenazadas = cantCelulasAmenazadas * 2
	}
	
	method cantCelulasAmenazadas() = cantCelulasAmenazadas
	
	method producirEfecto(persona){
		persona.modificarTemperatura(cantCelulasAmenazadas / 1000)
	}
	
	method esAgresiva(persona) = cantCelulasAmenazadas > 0.001 * persona.cantCelulas()
	
}

class EnfermedadAutoinmune{
	var cantVecesProducidoEfecto = 0
	var cantCelulasAmenazadas
	
	method cantCelulasAmenazadas() = cantCelulasAmenazadas
	
	method producirEfecto(persona){
		persona.modificarCelulas(-cantCelulasAmenazadas)
		cantVecesProducidoEfecto = cantVecesProducidoEfecto + 1
	}
	
	method esAgresiva(persona) = cantVecesProducidoEfecto > 30
}

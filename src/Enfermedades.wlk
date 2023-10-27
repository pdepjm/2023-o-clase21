class EnfermedadDeCelulas{
	var cantCelulasAmenazadas
	
	method cantCelulasAmenazadas() = cantCelulasAmenazadas

	//método abstracto - NO tiene implementación
	//obligo a las subclases a definir un comportamiento para
	//este
	method resistencia(dosis)

	method atenuar(dosis, persona){
		cantCelulasAmenazadas -= (dosis - self.resistencia(dosis)) * 15
		if(cantCelulasAmenazadas >= 0){
			persona.curarse(self)
		}
	}
}

class EnfermedadInfecciosa inherits EnfermedadDeCelulas{
	
	method reproducirse(){
		cantCelulasAmenazadas = cantCelulasAmenazadas * 2
	}
		
	method producirEfecto(persona){
		persona.modificarTemperatura(cantCelulasAmenazadas / 1000)
	}
	
	method esAgresiva(persona) = cantCelulasAmenazadas > 0.001 * persona.cantCelulas()
	
	override method resistencia(dosis) = 20
}

class EnfermedadAutoinmune inherits EnfermedadDeCelulas{
	var cantVecesProducidoEfecto = 0

	method producirEfecto(persona){
		persona.modificarCelulas(-cantCelulasAmenazadas)
		cantVecesProducidoEfecto = cantVecesProducidoEfecto + 1
	}
		
	method esAgresiva(persona) = cantVecesProducidoEfecto > 30
	
	override method resistencia(dosis) = dosis * 0.1
}

object hipotermia{
	
	method esAgresiva() = true
	
	method producirEfecto(persona){
		persona.bajarTodaTemperatura()
	}
}

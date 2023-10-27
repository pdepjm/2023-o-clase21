class Persona {
	var property temperatura = 36
	var property cantCelulas = 7000000
	const enfermedades = #{}
	
	method cantCelulas() = cantCelulas
	
	method contraer(enfermedad){
		self.validarCantidadEnfermedades()
		enfermedades.add(enfermedad)
	}
	
	method curarse(enfermedad){
		enfermedades.remove(enfermedad)
	}
	
	method validarCantidadEnfermedades(){
		if(enfermedades.size() >= 7){
			throw new DomainException(message="No se pueden contraer más enfermedades")
		}
	}
	
	method viviUnDia(){
		enfermedades.forEach({cadaEnf => cadaEnf.producirEfecto(self)})
	}
	
	method modificarTemperatura(cant){
		temperatura = (temperatura + cant).min(45)
	}
	
	method modificarCelulas(cant){
		cantCelulas = cantCelulas + cant
	}
	
	method estaEnComa() = cantCelulas < 1000000 || temperatura >= 40
	
	method cantidadDeCelulasAgresivas() = self.enfermedadesAgresivas().sum({cadaEnf => cadaEnf.cantCelulasAmenazadas()})

	method enfermedadesAgresivas() = enfermedades.filter({enfermedad => enfermedad.esAgresiva(self)})
	
	method laQueMasCelulasAfecta() = enfermedades.max({enfermedad => enfermedad.cantCelulasAmenazadas()})
	
	method recibirDosis(dosis){
		enfermedades.forEach({enfermedad => enfermedad.atenuar(dosis, self)})
	}
	
	method bajarTodaTemperatura(){
		temperatura = 0
	}
	
	method estabilizate(){
		temperatura = 36
	}
}


class Medico inherits Persona{
	var dosis
	var especialidad
	
	method atender(paciente){
		paciente.recibirDosis(dosis)
		especialidad.tratamientoExtra(paciente)
	}
	
	override method contraer(enfermedad){
		super(enfermedad) //superclase.contraer(enfermedad)
		self.atender(self)
	}
}

//Especialidades

class Cardiologo{
	var experiencia
	
	method tratamientoExtra(persona){
		persona.recibirDosis(10 * experiencia)
	}
}

object enfermero{
	
	method tratamientoExtra(persona){
		persona.recibirDosis(10)
	}
}

object guardia{
	method tratamientoExtra(persona){
		persona.estabilizate()
	}
}

object sinEspecialidad{
	method tratamientoExtra(persona){}
}

class JefeDepartamento inherits Medico {
	
	const subordinados = []
	
	override method atender(paciente){
		subordinados.anyOne().atender(paciente)
	}
}
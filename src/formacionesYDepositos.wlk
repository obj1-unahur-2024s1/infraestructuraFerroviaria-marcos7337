import vagonesYLocomotoras.*

class Deposito {
	const property formaciones = []
	const property locomotoras = []
	
	method vagonesMasPesados() = formaciones.map({for => for.vagonMasPesado()})
	
	method necesitaConductorExperimentado() = formaciones.any({for => for.esCompleja()})
	
	method hayLocomotoraQueMueva(formacion) = locomotoras.any({loc => loc.capacidadDeArrastre() >= formacion.empujeFaltante()})
	
	method locomotoraParaMover(formacion) = locomotoras.find({loc => loc.capacidadDeArrastre() >= formacion.empujeFaltante()})
	
	method agregarLocomotoraA(formacion) {
		if (!formacion.puedeMoverse() and self.hayLocomotoraQueMueva(formacion)){
			const loc1 = self.locomotoraParaMover(formacion)
			formacion.agregarLocomotora(loc1)
		}
	}
}

class Formacion {
	const property vagones = []
	const property locomotoras = []
	
	method agregarVagon(vagon) { vagones.add(vagon) }
	
	method quitarVagon(vagon) { vagones.remove(vagon) }
	
	method agregarLocomotora(locomotora) { vagones.add(locomotora) }
	
	method quitarLocomotora(locomotora) { vagones.remove(locomotora) }
	
	method capacidadDePasajeros() = vagones.sum({vagon => vagon.capacidadDePasajeros()})
	
	method cantidadDeVagonesPopulares() = vagones.count({vagon => vagon.esPopular()})
	
	method esFormacionCarguera() = vagones.all({vagon => vagon.capacidadDeCarga() >= 1000})
	
	method vagonMasPesado() = vagones.max({vagon => vagon.pesoMaximo()})
	
	method vagonMasLiviano() = vagones.min({vagon => vagon.pesoMaximo()})
	
	method dispersionDePeso() = self.vagonMasPesado().pesoMaximo() - self.vagonMasLiviano().pesoMaximo()
	
	method cantidadDeBanios() = vagones.count({vagon => vagon.tieneBanios()})
	
	method realizarMantenimiento() { vagones.forEach({vagon => vagon.hacerleMantenimiento()})}
	
	method vagonesConPasajeros() = vagones.filter({vagon => vagon.esDePasajeros()})
	
	method vagonConMasPasajeros() = self.vagonesConPasajeros().max({vagon => vagon.capacidadDePasajeros()})
	
	method vagonConMenosPasajeros() = self.vagonesConPasajeros().min({vagon => vagon.capacidadDePasajeros()})
	
	method hayEquilibrioDePasajeros() {
		return (self.vagonConMasPasajeros().capacidadDePasajeros() - self.vagonConMenosPasajeros()).capacidadDePasajeros() <= 20
	}
	
	method estaOrganizada() {
		const rango = (0..vagones.size()-2)
		return if(vagones.size() < 2) true 
		else !rango.any({i => !vagones.get(i).esDePasajeros() and vagones.get(i+1).esDePasajeros()}) 
	}
	
	method pesoMaximo() = vagones.sum({vagon => vagon.pesoMaximo()}) + locomotoras.sum({loc => loc.peso()})
	
	method capacidadDeArrastre() = locomotoras.sum({loc => loc.capacidadDeArrastre()})
	
	method velocidadMaxima() = locomotoras.map({loc => loc.velocidadMaxima()}).min()
	
	method esEficiente() = locomotoras.all({loc => loc.esEficiente()})
	
	method puedeMoverse() = self.capacidadDeArrastre() >= self.pesoMaximo()
	
	method empujeFaltante() = if(!self.puedeMoverse()) self.pesoMaximo() - self.capacidadDeArrastre() else 0
	
	method esCompleja() = (vagones.size() + locomotoras.size()) > 8 or self.pesoMaximo() > 80000
}





















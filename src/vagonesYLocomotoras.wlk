class VagonDePasajeros {
	var property estaOrdenado
	const property largo
	const property ancho
	const property tieneBanios
	
	method capacidadDePasajeros() {
		var capPasajeros = if (ancho <= 3) {largo * 8} else {largo * 10}
		capPasajeros = capPasajeros - if (!estaOrdenado) 15 else 0
		return capPasajeros
	}
	method capacidadDeCarga() = if (tieneBanios) 300 else 800
	method pesoMaximo() = 2000 + (self.capacidadDePasajeros() * 80) + self.capacidadDeCarga()
	method hacerleMantenimiento() { estaOrdenado = true }
	method esPopular() = self.capacidadDePasajeros() > 50
	method esDePasajeros() = true
}

class VagonDeCarga {
	var property cargaMaximaIdeal
	var property maderasSueltas
	const property tieneBanios = false
	
	method capacidadDeCarga() = cargaMaximaIdeal - (400 *  maderasSueltas)
	method pesoMaximo() = 1500 + cargaMaximaIdeal
	method capacidadDePasajeros() = 0
	method hacerleMantenimiento() {
		maderasSueltas = (maderasSueltas - 2).max(0)
	}
	method esPopular() = false
	method esDePasajeros() = false
}

class VagonDormitorio {
	var property compartimientos
	var property camasPorCompartimiento
	const property tieneBanios = true
	
	method capacidadDePasajeros() = compartimientos * camasPorCompartimiento
	method capacidadDeCarga() = 1200
	method pesoMaximo() = 4000 + (80 * self.capacidadDePasajeros()) + self.capacidadDeCarga()
	method hacerleMantenimiento() {}
	method esPopular() = self.capacidadDePasajeros() > 50
	method esDePasajeros() = true
}

class Locomotora {
	var property peso
	var property capacidadDeArrastre
	var property velocidadMaxima
	
	method esEficiente() = capacidadDeArrastre >= (peso * 5)
}






















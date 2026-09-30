/*
  APUNTES GUIA
  Proceso de desarrollo https://docs.google.com/document/d/1NNqwCuLb-TxSs5-jgmcqox8MwPTtakTZHA8191vOuHU/edit?tab=t.0
  Tests https://docs.google.com/document/d/1xtUAg9_XSLlGNilUADKrDuCFf_jYfgZcu-vrttNygZE/edit?tab=t.0#heading=h.8u2q0xt88h8h
  Clases https://docs.google.com/document/d/1yjNMBBlgqv_F_Fs1X7lBS54r-bexeD933dKOvh4oiRA/edit?tab=t.0
  Colecciones https://docs.google.com/document/d/1OJbaQIwIf1r23JbEzxqBJ5NgYW0lodbz2_MzbaGgNuk/edit?tab=t.0#heading=h.r2zj8m016hq
*/

class Torino {
  var color
  var velocidadMáx 
  var autonomía // distancia que puede recorrer sin cargar combustible

  method color() = color

  method velocidadMáx() = velocidadMáx

  method autonomía() = autonomía

  method capacidad() = 4 // cantidad de personas que puede transportar al mismo tiempo

  method esRuidoso() = true

  method puedeTransportarSillasDeRuedas() = false

}

class Económico {
  var property adaptaciones = #{}
  const capacidadBase = 5
  const velocidadMáxBase = 120 
  const autonomíaBase = 200 // distancia que puede recorrer sin cargar combustible

  method agregarAdaptación(adaptación) = adaptaciones.add(adaptación)

  method capacidad() = capacidadBase - self.capacidadDeAdaptaciones() // capacidad: cantidad de personas que puede transportar al mismo tiempo

  method capacidadDeAdaptaciones(){
    return adaptaciones.sum( { adaptación => adaptación.cantEspacioQueOcupa() } )
  } // o adaptaciones.size() ?

  method velocidadMáx() {
    return self.velocidadMáxDeAdaptaciones().minIfEmpty({velocidadMáxBase})
    //return ( self.velocidadMáxDeAdaptaciones() + velocidadMáxBase ).min()
  }

  method velocidadMáxDeAdaptaciones() {
    return adaptaciones.map( { adaptación => adaptación.velocidadMáx() } )
  }

  method puedeTransportarSillasDeRuedas() { // any devuelve booleano
    return adaptaciones.any( { adaptación => adaptación.puedeTransportarSillasDeRuedas() } )
  }

  method esRuidoso() {
    return not adaptaciones.any( { adaptación => not adaptación.esRuidoso() } )
  }

  method color() = "beige"

  method autonomía() {
    return autonomíaBase + self.autonomíaDeAdaptaciones()
  }

  method autonomíaDeAdaptaciones() {
    return adaptaciones.sum( { adaptación => adaptación.autonomía() } )
  }
}

object trasportadorDeSillaRuedas {
  method cantEspacioQueOcupa() = 1
  method velocidadMáx() = 90
  method puedeTransportarSillasDeRuedas() = true
  method esRuidoso() = true // ? porque no influye, o queda vacio
  method autonomía() = -20
}

object cañoDeEscapeSilencioso {
  method cantEspacioQueOcupa() = 0
  method velocidadMáx() = 115
  method puedeTransportarSillasDeRuedas() = false
  method esRuidoso() = false
  method autonomía() = -10
}

object tanqueExtraDeGas {
  method cantEspacioQueOcupa() = 1
  method velocidadMáx() = 80
  method puedeTransportarSillasDeRuedas() = false
  method esRuidoso() = false
  method autonomía() = 200
}

object combiAdaptable {
  var property color = "celeste"
  var property interior = interiorAccesible
  var property motor = motorUrbano

  method capacidad() = interior.capacidad()
  method puedeTransportarSillasDeRuedas() = interior.puedeTransportarSillasDeRuedas()
  method velocidadMáx() = motor.velocidadMáx()
  method autonomía() = motor.autonomía()
  method esRuidoso() = motor.esRuidoso()
}

object interiorEspacioso {
  method capacidad() = 7
  method puedeTransportarSillasDeRuedas() = false
}

object interiorAccesible {
  method capacidad() = 5
  method puedeTransportarSillasDeRuedas() = true
}

object motorDeportivo {
  method velocidadMáx() = 230
  method autonomía() = 400
  method esRuidoso() = true
}

object motorUrbano {
  method velocidadMáx() = 130
  method autonomía() = 1000
  method esRuidoso() = false
}
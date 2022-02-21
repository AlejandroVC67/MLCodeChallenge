//
//  Environment.swift
//  MLCodeChallenge
//
//  Created by Diego Alejandro Villa Cardenas on 20/02/22.
//  Copyright © 2022  . All rights reserved.
//

import Foundation
// Environtment, Struct que agrupa todas las dependencias del sistema como propiedades de esta struct
// se define como variable global dentro del modulo
// concepto de LIVE y la declaracion para DEBUG y access level control (internal)
// Primero, identificar la dependencia a invertir
// si tiene protocolo, convertir el protocolo a una representacion concreta de sus llamados (crear una struct)
// Crear la version LIVE o de las dependencias/llamados externos
// reemplazar los usos de esta dependencia por la nueva representación
// Testabilidad adquirida + preview + Unit test
// en preview mostrar las ventajas de tener helpers staticos para mejorar la ergonomia
// mostrar el failing como punto de comienzo para controlar que es llamado y que no.

struct Environment {
    var categoriesSearchClient: CategoryServiceClient
}

#if DEBUG
var environment: Environment = .live
#else
let environment = Environment.live
#endif

extension Environment {
    static let live = Self(
        categoriesSearchClient: .live
    )
}

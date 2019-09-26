//
//  Filtro.swift
//  Recicla Facil
//
//  Created by aluno on 26/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class Filtro{
    var nome:String!
    var valor:Bool!
    
    init(){}
    
    init(nome:String,valor:Bool){
        self.nome = nome
        self.valor = valor
    }
}

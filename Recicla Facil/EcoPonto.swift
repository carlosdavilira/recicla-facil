//
//  EcoPonto.swift
//  Recicla Facil
//
//  Created by aluno on 18/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class EcoPonto: Codable {
    var nome:String!
    var endereco:String!
    var bairro:String!
    var latitude:Double!
    var longitude:Double!
    
    init(){}
    
    init(nome:String,endereco:String,bairro:String,latitude:Double,longitude:Double){
        self.nome = nome
        self.endereco = endereco
        self.bairro = bairro
        self.latitude = latitude
    }
    
}

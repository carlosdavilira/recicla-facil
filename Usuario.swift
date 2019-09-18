//
//  Usuario.swift
//  Recicla Facil
//
//  Created by aluno on 17/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class Usuario {
    
    var id : String =  ""
    var primeiroAcesso: Bool = false
    init(){}
    
    init(id: String, primeiroAcesso:Bool){
        self.id = id
        self.primeiroAcesso = primeiroAcesso
    }
   
    
}

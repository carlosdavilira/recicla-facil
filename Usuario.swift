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
    var email:String = ""
    var senha:String = ""
    
    
    init(){}
    
    init(id: String, primeiroAcesso:Bool,email:String,senha:String){
        self.id = id
        self.primeiroAcesso = primeiroAcesso
        self.email = email
        self.senha = senha
    }
   
    
}

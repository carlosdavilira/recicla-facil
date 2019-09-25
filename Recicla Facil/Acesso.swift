//
//  Acesso.swift
//  Recicla Facil
//
//  Created by aluno on 20/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation

class Acesso {
    var acessosUsuarios:[Usuario] = []
    
    init(){}
    
    //Esses dois dados vem do UserDefaults
    var login:String = "Exemplo"
    var email:String = "exemplo@gmail.com"
    
    
    func verificaPrimeiroAcesso() -> Bool{
        var refListaUsuarios = UserDefaults.standard.object(forKey: "listaUsuarios") as! [Usuario]
        
        if(refListaUsuarios == nil) {
            print("Nenhum usuario criado")
            return false
        }
        var listaUsuarios:[Usuario] = []
        listaUsuarios = refListaUsuarios
        
        if listaUsuarios.isEmpty {
            //primeiro acesso sem nenhum usuario
            var user: Usuario = Usuario.init(id:self.email,primeiroAcesso:true)
            print("Nenhum usuario registrado")
            return false
        }
        for user in refListaUsuarios {
            if user.id == self.login{
                print("Usuario existe")
                return true
            }
        }
        print("Usuario selecionado não existe")
        return false
    }
    
    func setaPrimeiroAcesso(){
        
    }
    
    
    
    
}

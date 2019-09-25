//
//  ReciclaAPI.swift
//  Recicla Facil
//
//  Created by aluno on 18/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import Foundation
import UIKit
class ReciclaAPI {
    
    init(){}
    
    func request(_ completionHandler: @escaping ([EcoPonto]) -> Void ) -> [EcoPonto]{
        var listaEcoPontosRetorno:[EcoPonto] = []
        if let url = URL(string: "http://mism12.kinghost.net:21001/getEcoPontos"){
            let tarefa = URLSession.shared.dataTask(with: url) {
                (dados, requisicao, erro) in
                if (erro == nil) {
                 if let dadosRetorno = dados
                 {
                    do {
                        let jsonDecoder = JSONDecoder()
                        
                        let ecoPontos = try jsonDecoder.decode([EcoPonto].self, from: dadosRetorno)
                        listaEcoPontosRetorno = ecoPontos
                        print(ecoPontos)
                        
                        completionHandler(listaEcoPontosRetorno)
                      
                    } catch{
                        print("Erro ao formatar retorno")
                    }
                   
                    print("sucesso ao fazer consulta ")
                    
                }
                } else {
                    print("Erro ao fazer consulta \(erro?.localizedDescription)")
                }
            }
            tarefa.resume()
            }
        return listaEcoPontosRetorno
    }
    
}
    



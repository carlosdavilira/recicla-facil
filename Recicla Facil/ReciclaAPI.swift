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
    
    func request() -> [EcoPonto]{
        var listaEcoPontosRetorno:[EcoPonto] = []
        if let url = URL(string: "http://mism12.kinghost.net:21001/getEcoPontos"){
            let tarefa = URLSession.shared.dataTask(with: url) {
                (dados, requisicao, erro) in
                if (erro == nil) {
                 if let dadosRetorno = dados
                 {
                    do {
                        
                        let listaEcoPontos = try JSONSerialization.jsonObject(with: dados!, options: []) as! [[String:Any]]
                        
                        
                        for unidade in listaEcoPontos {
                            let  econPonto = EcoPonto.init(nome: unidade["nome"] as! String,
                                endereco: unidade["endereco"] as! String,
                                bairro: unidade["bairro"] as! String,
                                latitude: unidade["latitude"] as! Double,
                                longitude: unidade["longitude"] as! Double
                            )
                            listaEcoPontosRetorno.append(econPonto)
                        }
                       
                      //  guard let nomePonto = listaEcoPontos[0]["endereco"] as? String else { return }
                        //print(nomePonto)
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
    



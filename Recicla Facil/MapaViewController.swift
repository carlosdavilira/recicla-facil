//
//  MapaViewController.swift
//  Recicla Facil
//
//  Created by aluno on 18/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocal = CLLocationManager()
    var ecoPontos:[EcoPonto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        gerenciadorLocal.delegate = self
        gerenciadorLocal.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocal.requestWhenInUseAuthorization()
        gerenciadorLocal.startUpdatingLocation()
       /*
        //Criando coordendas
        let lat: CLLocationDegrees = -3.8226478
        let lon: CLLocationDegrees = -38.5634409
        
        //criando objeto de localizacao com coordendas
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,lon)
        
        //criando nivel do zoom
        let deltaLatitude:CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        //criando area de vizualizacao com o zoom
        let areaVizualizacao = MKCoordinateSpan(latitudeDelta: deltaLatitude,longitudeDelta: deltaLongitude)
        
        //criando regiao com a localizacao e a area de visualizacao
        let regiao: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVizualizacao)
        //setando mapa
        mapa.setRegion(regiao, animated: true)
        // Do any additional setup after loading the view.
        
        
        let anotacao =  MKPointAnnotation()
        anotacao.coordinate = localizacao
        anotacao.title = "Ecoponto Mondubim II"
        anotacao.subtitle = "Esquina com a Rua B"
        mapa.addAnnotation(anotacao)*/
        
     /*   var ecoPontos:[EcoPonto] = []
        ecoPontos.append(EcoPonto.init(nome: "Ecoponto Mondubim II",endereco: "Rua Mangaba, 170,Esquina com a Rua B",bairro:"MONDUBIM",latitude:-3.8226478,longitude: -38.5634409))
        ecoPontos.append(EcoPonto.init(nome: "Ecoponto Damas",endereco: "Rua Júlio César, 1532 (Entre a Rua Macedo e a Rua Afrodísio Godim)",bairro:"DAMAS",latitude:-3.7555436,longitude: -38.5476395))*/
        var reciclaApi = ReciclaAPI.init()
        reciclaApi.request { (pontos) in
             self.ecoPontos = pontos
             self.plotarPontosMapa(listaEcopontos: pontos)
        }
        
        //TODO Ecopontos ainda nao plotam corretamente. necessario ver se o array esta sendo preenchido corretamente
       
      
        
    }
    
    func plotarPontosMapa(listaEcopontos:[EcoPonto]){
        for ecoPonto in listaEcopontos {
            let lat: CLLocationDegrees = ecoPonto.latitude
            let lon: CLLocationDegrees = ecoPonto.longitude
            
            let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,lon)
            
            let deltaLatitude:CLLocationDegrees = 0.1
            
            let deltaLongitude: CLLocationDegrees = 0.1
            
            let areaVizualizacao = MKCoordinateSpan(latitudeDelta: deltaLatitude,longitudeDelta: deltaLongitude)
            
            let regiao: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVizualizacao)
            
            mapa.setRegion(regiao, animated: true)
            
            let anotacao =  MKPointAnnotation()
            anotacao.coordinate = localizacao
            anotacao.title = ecoPonto.nome
            anotacao.subtitle = ecoPonto.endereco
            mapa.addAnnotation(anotacao)
         
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

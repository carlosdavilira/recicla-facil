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

        var reciclaApi = ReciclaAPI.init()
        reciclaApi.request { (pontos) in
             self.ecoPontos = pontos
             DispatchQueue.main.async {
                  self.plotarPontosMapa(listaEcopontos: pontos)
            }
        }
        
      
        //TODO Ecopontos ainda nao plotam corretamente. necessario ver se o array esta sendo preenchido corretamente
       
      
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacaoUsuario: CLLocation = locations.last!
        
        let lat: CLLocationDegrees = localizacaoUsuario.coordinate.latitude
        let lon: CLLocationDegrees = localizacaoUsuario.coordinate.longitude
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,lon)
        
        let deltaLatitude:CLLocationDegrees = 0.08
        
        let deltaLongitude: CLLocationDegrees = 0.08
        
        let areaVizualizacao = MKCoordinateSpan(latitudeDelta: deltaLatitude,longitudeDelta: deltaLongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: mapa.region.span)
        
        
        mapa.setRegion(regiao, animated: true)
    }
    
    func plotarPontosMapa(listaEcopontos:[EcoPonto]){
        for ecoPonto in listaEcopontos {
            let lat: CLLocationDegrees = ecoPonto.latitude
            let lon: CLLocationDegrees = ecoPonto.longitude
            
            let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,lon)
            
            let deltaLatitude:CLLocationDegrees = 0.01
            
            let deltaLongitude: CLLocationDegrees = 0.08
            
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


}



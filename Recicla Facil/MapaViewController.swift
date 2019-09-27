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
    var userRegiao:MKCoordinateRegion!
    @IBOutlet weak var tableView: UITableView!
    var filtros:[Filtro] = []
    
    @IBOutlet weak var refButtonCentralizar: UIButton!
    
    @IBAction func Logout(_ sender: Any) {
        
      
        performSegue(withIdentifier: "logOutIdentifier", sender: nil)
        
        
    }
    

    
    @IBAction func ChamarFiltros(_ sender: Any) {
        tableView.isHidden = !(tableView.isHidden)
    }
    
    
    @IBAction func CentralizarMapa(_ sender: Any) {
        mapa.setRegion(userRegiao, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CriacaoFiltros()
        UIPersonalize()
        
        tableView.isHidden = true
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
        userRegiao = MKCoordinateRegion(center: localizacao, span: areaVizualizacao)
        
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

    func CriacaoFiltros(){
        self.filtros.append(Filtro.init(nome: "Metal", valor: true))
        self.filtros.append(Filtro.init(nome: "Eletronico", valor: true))
        self.filtros.append(Filtro.init(nome: "Madeira", valor: true))
        self.filtros.append(Filtro.init(nome: "Celulares", valor: true))
        self.filtros.append(Filtro.init(nome: "Plasticos", valor: true))
        self.filtros.append(Filtro.init(nome: "Pilhas e baterias", valor: true))
        self.filtros.append(Filtro.init(nome: "Móveis", valor: true))
        self.filtros.append(Filtro.init(nome: "Entulho", valor: true))
        self.filtros.append(Filtro.init(nome: "Vidro", valor: true))
    }
    func UIPersonalize(){
        // Shadow and Radius
        refButtonCentralizar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        refButtonCentralizar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        refButtonCentralizar.layer.shadowOpacity = 1.0
        refButtonCentralizar.layer.shadowRadius = 0.0
        refButtonCentralizar.layer.masksToBounds = false
       
    }

}


extension MapaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var filtro = filtros[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FiltroTableViewCell
        
        cell.nomeFiltro.text = filtro.nome
        cell.valor.isOn = filtro.valor
        
        return cell
    }
    
    
    
    
}




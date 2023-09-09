//
//  MapViewModel.swift
//  WellConnectLive
//
//  Created by Alex Riquelme on 09-09-23.
//

import Foundation
import MapKit


private var token = "6deac6dba267d5e61ff81badc1757b89"

struct Address: Codable {
    let data: [Datum]
    
}


struct Datum: Codable{
    let latitude, longitude : Double
    let name : String?
    
}

struct Location: Identifiable {
    let id = UUID()
    let name : String
    let coordinate: CLLocationCoordinate2D
}


class MapAPI: ObservableObject{
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY = token
    
    @Published var region: MKCoordinateRegion
    @Published var coordinates = []
    @Published var locations: [Location] = []
    
    
    init(){
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.40415, longitude: -3.68991), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 40.40, longitude: -3.68998)),at: 0)
    }
    

    func getLocation(address: String, delta: Double){
        let pAddress = address.replacingOccurrences(of: " ", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
        
        
        guard let url = URL(string: url_string) else{
            print("url invalida")
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data
            else{
                print(error!.localizedDescription)
                return
            }
            
            guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data)
            else {
                return
            }
            
            if newCoordinates.data.isEmpty{
                print("No se pudo encontrar la dirección")
                return
            }
            
            DispatchQueue.main.async {
                let details = newCoordinates.data[0]
                let lat = details.latitude
                let lon = details.longitude
                let name = details.name
                self.coordinates = [lat, lon]
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
                
                let new_location = Location(name: name ?? "Pin", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                self.locations.removeAll()
                self.locations.insert(new_location, at: 0)
                
                print("Dirección cargada correctamente!!!")
            }
            
        }
        .resume()
        
    }
    
    
}




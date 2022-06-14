//
//  WeatherData.swift
//  App3x 8.1 Clima
//
//  Created by Marwan Elbahnasawy on 25/05/2022.
//

import Foundation
struct WeatherData : Decodable {
    
    var weather : [Weather]
    var main : Main
    
    struct Weather: Decodable {
        var id : Int
    }
    
    struct Main: Decodable {
        var temp : Double
    }
    
    var name : String
}

//
//  WeatherManager.swift
//  App3x 8.1 Clima
//
//  Created by Marwan Elbahnasawy on 25/05/2022.
//

import Foundation

protocol changeUI {
    func changeUI()
}

class WeatherManager {
    
    var delegate : changeUI!
    
    var cityName : String!
    var temp : Double!
    var id: Int!
    var weatherConditionString : String!
    
    let urlStringInitial = "https://api.openweathermap.org/data/2.5/weather?appid=f112a761188e9c22cdf3eb3a44597b00&units=metric"
    
    func getWeather(url: URL) {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let safeData = data {
                self.parseJSON(data : safeData)
            }
        }
        task.resume()
        
    }
    
    func parseJSON (data: Data) {
        let decoder = JSONDecoder()
        do {
        let decodedData = try decoder.decode(WeatherData.self, from: data)
            cityName = decodedData.name
            id = decodedData.weather[0].id
            temp = (decodedData.main.temp * 10).rounded()/10
            weatherConditionString = getWeatherCondition()
            
            delegate.changeUI()
            
        }
        catch {
            print("Error while decoding: \(error)")
        }
        }
    
    func getWeatherCondition() -> String{
        switch id! {
        case 200 ... 299:
        return "cloud.blot"
        case 300 ... 399:
        return "cloud.drizzle"
        case 500 ... 599:
        return "cloud.rain"
        case 600 ... 699:
        return "cloud.snow"
        case 700 ... 799:
        return "cloud.fog"
        case 800:
        return "sun.max"
        case 800 ... 899:
        return "cloud"
        default :
        return "sun.max"
    }
    
    }
}
    

//
//  ViewController.swift
//  App3x 8.1 Clima
//
//  Created by Marwan Elbahnasawy on 25/05/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, changeUI {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    
    
    var weatherManager = WeatherManager()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.endEditing(true)
        return true
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.placeholder = "You forgot to type?"
        }
        else {
            let urlString = weatherManager.urlStringInitial + "&q=\((textField.text! as NSString).replacingOccurrences(of: " ", with: "+"))"
            weatherManager.getWeather(url: URL(string: urlString)!)
        }
    }
    
    @IBAction func gpsClicked(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = currentLocation.coordinate.latitude
            let lon = currentLocation.coordinate.longitude
            let urlString = weatherManager.urlStringInitial + "&lat=\(lat)&lon=\(lon)"
            weatherManager.getWeather(url: URL(string: urlString)!)
            textField.resignFirstResponder()
            textField.text = ""
        }
        
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error, failed with error on updating locations: \(error)")
    }
    
    func changeUI(){
        DispatchQueue.main.async { [self] in
            cityNameLabel.text = weatherManager.cityName
            tempLabel.text = "\((weatherManager.temp)!) C"
            weatherConditionImage.image = UIImage(systemName: weatherManager.weatherConditionString)
        }
        }
        
    
}


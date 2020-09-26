//
//  WeatherViewController.swift
//  Weather
//
//  Created by ahmet on 26.09.2020.
//  Copyright © 2020 ahmetguvez. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchText: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Locationmenager kullanırken delegate methodlardan yukarda olması gereklidir.WhenisUseAut metodu kullanıcının uygulamayu kullanırken konumuna erişmesilmesini sorar.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchText.delegate = self
        // delegate ile weathermenager sıfının temsilcisini artık buraya atadık temsilci bu sınıf olacaktır.
        weatherManager.delegate = self

    }
    @IBAction func searchButton(_ sender: UIButton) {
        print(searchText.text!)
        searchText.endEditing(true)
        //  butona basıldıktan sonra klavyenin kaybolmasını sağlar
    }
    @IBAction func locationButton(_ sender: UIButton) {
        
        locationManager.requestLocation()

    }
    
}
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // kullanıcı düzenlemeyi durdurduğunda tetiklenir.Yani textfielda veri girip sonlandırdığında çalışır
        if let cityName = searchText.text {
            weatherManager.cityName(name: cityName)
        }
        searchText.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // klavyedeki return(dönüş) tuşuna basıldıysa gerçekleşecek eylemler buraya girilir.
        print(searchText.text!)
        searchText.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if searchText.text != "" {
            return true
        }else {
            searchText.placeholder = "Bir şeyler yazın"
            return false
        }
        
    }
    
}

extension WeatherViewController : WeatherMenagerProtocol{
    
    func didUpdateWeather(weathermodel:WeatherModel){
        
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weathermodel.ımageId)
            self.temperatureLabel.text = weathermodel.temp
            self.cityLabel.text = weathermodel.weatherName
        }
        print(weathermodel.temp)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension WeatherViewController : CLLocationManagerDelegate{
    //eğer izin verilmişse aşağıdaki methodlar tetiklenir.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // kullanıcının konumunu alırız.
        if let location = locations.last {
            locationManager.stopUpdatingLocation() // kullanıcı uygulamada konum butonuna bastığında tekrar güncellenir ancak bu yöntem çalıştığında konumla ilgili olaylar tetiklenmez.Konum güncellemeleri durur.
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.coordinateUrl(lat: lat,lon: lon)
            
            
        }
        
    }
    
}

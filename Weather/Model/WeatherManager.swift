//
//  WeatherManager.swift
//  Weather
//
//  Created by ahmet on 26.09.2020.
//  Copyright © 2020 ahmetguvez. All rights reserved.
//

import Foundation
//Controller sınıfına verileri aktarmak için Bir protocol oluştururuz ve delegate ile verileri atayabiliriz.Temsilciyi bu sınıftan oluşturacağız çünkü veriler bu sınıftan gidektir.Aktaradığımız sınıfta temsilciği o sınıfa atayacağız.
//bu yöntemi kullanma amaclarından biri verileri teker teker göndermemek ve değişiklik olduğunda kodu değiştirmekten kaçınmaktır.Bu sayede direk model sınıfını gönderiyoruz ve herhangi bir değişiklik yapıldığında protocolü veya ilgili sınıfı değiştirebiliriz.
protocol WeatherMenagerProtocol {
    
    func didUpdateWeather(weathermodel: WeatherModel)
    func didFailWithError(error : Error)
}
struct WeatherManager {
    
    var delegate : WeatherMenagerProtocol?
    
    func cityName(name : String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=251f79324f84faa562903e540661df6d&units=metric"
        print(url)
        getRequest(requestUrl: url)
    }
    func coordinateUrl(lat:Double,lon:Double){

        let urlCoordinate = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=251f79324f84faa562903e540661df6d&units=metric"
        
        getRequest(requestUrl: urlCoordinate)
        
    }
    
    func getRequest(requestUrl : String) {
        // 1- oluşturduğumuz url i initilaizer ederiz başlatırız.
        if let url = URL(string: requestUrl) {
            
            // 2. adım bir urlsession yani url oturumu oluşturmak olacak
            let session = URLSession(configuration: .default)
            
            // 3. adım oluşturuduğumuz oturuma bir  görev oluşturmaktır.
            
            let task =  session.dataTask(with: url) { (data,response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                    // hata var ise direk methodu terkeder çalıştırmaya devam etmez.
                }
                if let safeData = data {
                    if let weithermodel = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(weathermodel: weithermodel)
                    }
                }
                
            }
            
            // 4. adım görevi başlatmak olacak.
            
            task.resume()
        }

    }
    func parseJSON(_ weatherData : Data) -> WeatherModel?{
        
        // json verilerini ayrıştırmak için verilerin nasıl yapılandırıldığını bildirmek gerekiyor.Bunu model kullanarak yaparız.
        
        let decoder = JSONDecoder()
        
        do {
            let decodable = try decoder.decode(WheatherData.self, from: weatherData)
            let id = decodable.weather![0].id
            let name = decodable.name
            let temp = decodable.main!.temp
            print(name!)
            let weatherModel = WeatherModel(weatherName:name!, weatherId: id!, weatherTemp: temp!)
            
            return weatherModel
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}

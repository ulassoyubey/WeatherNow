//
//  HomePagePresenter.swift
//  WeatherNow
//
//  Created by ulas soyubey on 20.05.2022.
//

import Foundation
import Alamofire

protocol HomePageProtocol {
    func viewDidLoad()
    func setWeatherData()
    func setCityName()
    func getImageUrl() -> String
    func getForecastCount() -> Int?
    func getWeatherAtIndex(index:Int) -> Hour?
}


class HomePagePresenter:HomePageProtocol {
    
    private let interactor:HomePageInteractorProcotol
    private let router:HomePageRouterProtocol
    weak var view:HomePageViewProtocol?
    var weatherData:HourlyForecast?
    var weatherForecast:[Hour]?
    var customizedWeatherData:String = ""
    
    init(interactor:HomePageInteractorProcotol
         ,router:HomePageRouterProtocol
         ,view:HomePageViewProtocol?) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.interactor.fetchCurrentWeather(with: "Izmir")
        self.interactor.fetchNumberDayForecast(with: "Izmir", day: "1")
    }
    
    func getWeatherAtIndex(index: Int) -> Hour?{
        if let weatherForecast = weatherForecast {
            return weatherForecast[index]
        }
        return nil
    }
    
    func getForecastCount() -> Int? {
        if let weatherForecast = weatherForecast {
            return weatherForecast.count
        }
        else {
            return 0
        }
    }
    
    
    func getImageUrl() -> String {
        let weatherImageUrl = weatherData?.current.condition.icon ?? "//cdn.weatherapi.com/weather/64x64/day/113.png"
        return  "https://" +  String(weatherImageUrl.dropFirst(2))
    }
    
    func viewDidLoad() {
        view?.configureNavBar(cityName: "N/A")
        view?.setWeatherLabel(weatherData: "0")
        view?.setWeatherDescription(weatherDescription: "N/A")
        view?.configureBottomContainer()
        view?.configureStackView()
    }
    
    func setWeatherData() {
        let currentTemp = weatherData?.current.tempC.toInt()!
        customizedWeatherData = String(currentTemp!) + "°C"
        view?.setWeatherLabel(weatherData: customizedWeatherData)
        view?.setWeatherDescription(weatherDescription: weatherData?.current.condition.text ?? "N/A")
    }
    
    func setCityName() {
        
        if let cityString = weatherData?.location.name, let countryString = weatherData?.location.country {
            view?.configureNavBar(cityName: cityString + ", " + countryString)
        }else {
            view?.configureNavBar(cityName: "N/A")
        }
    }
    
}

extension HomePagePresenter : HomePageInteractorOutput {
    func handleNumberDayForecast(_ result: Result<AllDayForecast, AFError>) {
        switch result {
        case .success(let alldayForecast):
            self.weatherForecast = alldayForecast.forecast.forecastday.first?.hour.filter({ $0.time.toDate()! > Date.getCurrentDate()})
            view?.configureCollectionView()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func handleCurrentWeather(_ result: Result<HourlyForecast, AFError>) {
        switch result {
        case .success(let forecast):
            self.weatherData = forecast
            self.setWeatherData()
            self.setCityName()
            view?.setWindFieldText(topLabelText: "Wind Speed", descLabelText: String(forecast.current.windKph))
            view?.setHumidityFieldText(topLabelText: "Humidity", descLabelText: String(forecast.current.humidity))
            view?.setVisibilityTextFiled(topLabelText: "Visibility", descLabelText: String(forecast.current.visKM))
            view?.updateImage()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

}

//
//  HomePageInteractor.swift
//  WeatherNow
//
//  Created by ulas soyubey on 20.05.2022.
//

import Foundation
import Alamofire

protocol HomePageInteractorProcotol {
    func fetchCurrentWeather(with name:String)
    func fetchNumberDayForecast(with name:String,day:String)
}

protocol HomePageInteractorOutput: AnyObject {
    func handleCurrentWeather(_ result: Result<HourlyForecast,AFError>)
    func handleNumberDayForecast(_ result: Result<AllDayForecast,AFError>)
    //func handleDailyForecast()
}


class HomePageInteractor: HomePageInteractorProcotol {
    
    private let requestManager:HomePageRequestManager
    
    weak var output:HomePageInteractorOutput?
    
    init(requestManager:HomePageRequestManager = HomePageRequestManager()){
        self.requestManager = requestManager
    }

    func fetchCurrentWeather(with name: String) {
        requestManager.getCurrentWeather(cityName: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let forecast):
                self.output?.handleCurrentWeather(.success(forecast))
            case .failure(let error):
                self.output?.handleCurrentWeather(.failure(error))
            }
        }
    }
    
    func fetchNumberDayForecast(with name: String, day: String) {
        requestManager.getAllDayForecast(cityName: name, day: day) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let alldayForecast):
                self.output?.handleNumberDayForecast(.success(alldayForecast))
            case .failure(let error):
                self.output?.handleNumberDayForecast(.failure(error))
            }
        }
    }
    
}

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
    //func fetchNumberDayForecast(with name:String,day:Int)
}

protocol HomePageInteractorOutput: AnyObject {
    func handleCurrentWeather(_ result: Result<HourlyForecast,AFError>)
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
    
}

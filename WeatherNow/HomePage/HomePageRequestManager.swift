//
//  HomePageRequestManager.swift
//  WeatherNow
//
//  Created by ulas soyubey on 20.05.2022.
//

import Foundation
import Alamofire


class HomePageRequestManager{
    
    func getCurrentWeather(cityName:String,completion: @escaping (Result<HourlyForecast,AFError>) -> Void){
        var apiRoute = GetCurrentWeather()
        apiRoute.addQueryParameter(key: "q", value: cityName)
        RestManager.shared.sendRequest(apiRoute, completion: completion)
    }
}

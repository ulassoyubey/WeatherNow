//
//  AllDayForecastApiRoute.swift
//  WeatherNow
//
//  Created by ulas soyubey on 28.05.2022.
//

import Foundation
import Alamofire

struct GetAllDayWeather: APIRouteable {
    var path: String = "forecast.json"
    
    var method: HTTPMethod = .get
    
    var parameters: Parameters? = [
        "key": "9d1ad9bd292e42dca8b205246222405",
        ]
    
    var encoding: ParameterEncoding = URLEncoding.queryString

}

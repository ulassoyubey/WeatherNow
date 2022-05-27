//
//  HourlyForeCastApiRoute.swift
//  WeatherNow
//
//  Created by ulas soyubey on 25.05.2022.
//

import Foundation
import Alamofire

struct GetCurrentWeather : APIRouteable {
    var path: String = "current.json"
    
    var method: HTTPMethod = .get
    
    var parameters: Parameters? = [
        "key": "9d1ad9bd292e42dca8b205246222405",
        ]
    
    var encoding: ParameterEncoding = URLEncoding.queryString
    
    
}

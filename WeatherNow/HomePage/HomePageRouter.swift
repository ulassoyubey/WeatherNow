//
//  HomePageRouter.swift
//  WeatherNow
//
//  Created by ulas soyubey on 20.05.2022.
//

import Foundation
import UIKit


protocol HomePageRouterProtocol {
    
    //var entry:UIViewController? {get}
    //static func build() -> UIViewController
}

class HomePageRouter:HomePageRouterProtocol {
    var entry: UIViewController?
    
    static func build() -> UIViewController {
        let router = HomePageRouter()
        let interactor = HomePageInteractor()
        let view = HomePageViewController()
        let presenter = HomePagePresenter(interactor: interactor, router: router, view: view)
        
        interactor.output = presenter
        view.presenter = presenter
                
        return view
    }
}



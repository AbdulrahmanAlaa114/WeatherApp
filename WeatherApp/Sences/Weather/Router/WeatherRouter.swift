//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import UIKit

class WeatherRouter: WeatherRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = WeatherViewController()
        let interactor = WeatherInteractor()
        let router = WeatherRouter()
        let presenter = WeatherPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}

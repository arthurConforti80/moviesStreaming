//
//  Storyboards.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import UIKit

enum AppStoryboard: String {
    case main = "Main"

    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T

    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}


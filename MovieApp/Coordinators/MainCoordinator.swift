//
//  MainCoordinator.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import Foundation
import UIKit

struct CoordinatorStack<Element> {
    var items = [Element]() {
        didSet {
            #if !PROD
            print(items)
            #endif
        }
    }
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() {
        if !items.isEmpty {
            items.removeLast()
        }
    }
    
    mutating func clear() {
        if !items.isEmpty {
            items.removeAll()
        }
    }
}

public class MainCoordinator: NSObject, UINavigationControllerDelegate {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    public func start() {
        navigationController.delegate = self
        HomeController()
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
    
    private func HomeController() {
        let svc = HomeViewController.instantiate(fromAppStoryboard: .main)
        let viewModel = HomeViewModel()
        viewModel.coordinatorDelegate = self
        svc.viewModel = viewModel
        navigationController.pushViewController(svc, animated: false)
    }
    
    private func DetailController(idMovie: Int) {
        let detail = DetailsViewController.instantiate(fromAppStoryboard: .main)
        let viewModel = DetailViewModel()
        viewModel.idMovie = idMovie
        viewModel.coordinatorDelegate = self
        detail.viewModel = viewModel
        navigationController.pushViewController(detail, animated: false)
    }

}

extension MainCoordinator: HomeViewModelCoordinatorDelegate {
    func didTapMoviewDetail(id: Int) {
        self.DetailController(idMovie: id)
    }
}

extension MainCoordinator: DetailViewModelCoordinatorDelegate {
    func didTapHome() {
        HomeController()
    }
}



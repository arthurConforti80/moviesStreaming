//
//  UIViewController.swift
//  MovieApp
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard: AppStoryboard) -> Self {
        return fromAppStoryboard.viewController(viewControllerClass: self)
    }

    func setupNavigationBar(isHidden: Bool? = false, isTranslucent: Bool? = false, title: String? = "", backButtonTitle: String? = "", backgroungColor: UIColor? = UIColor.clear, backButtonImage: UIImage? = UIImage(named: "icon-back"), animated: Bool) {
        navigationController?.navigationItem.title = title
        
        navigationController?.setNavigationBarHidden(isHidden!, animated: animated) // navigationBar.isHidden = isHidden!
        navigationController?.view.backgroundColor = backgroungColor
        navigationController?.navigationBar.isTranslucent = isTranslucent!
        
        if isTranslucent! {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.view.backgroundColor = backgroungColor
        }
        
        let backButtonImageView = UIImageView(image: backButtonImage)
        
        let templateImage = backButtonImageView.image?.withRenderingMode(.alwaysTemplate)
        backButtonImageView.image = templateImage
        backButtonImageView.tintColor = UIColor.blue
        
        navigationController?.navigationBar.backIndicatorImage = backButtonImageView.image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImageView.image
        navigationController?.navigationBar.backItem?.title = backButtonTitle
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
    }

    func insertBlurBackground() {
        view.backgroundColor = UIColor.clear
        let blurBgView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurBgView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(blurBgView, at: 0)
        
        NSLayoutConstraint.activate([
            blurBgView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurBgView.widthAnchor.constraint(equalTo: view.widthAnchor)])
    }
}


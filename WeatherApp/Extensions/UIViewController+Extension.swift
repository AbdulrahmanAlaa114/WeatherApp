//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.35)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func hideSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func showAlert(title: String = "", message: String = "", actions: [UIAlertAction] = []) {
        var actions = actions
        if actions.isEmpty {
            let okAction = UIAlertAction(title: "Ok", style: .default)
            actions.append(okAction)
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        
        if self.presentedViewController as? UIAlertController != nil {
            self.dismiss(animated: true, completion: nil)
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}

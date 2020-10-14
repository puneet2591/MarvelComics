//
//  AlertUtility.swift
//  MarvelComics
//
//  Created by apple on 24/03/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

typealias AlertResponse = (Bool) -> Void


import UIKit

// Structure for Alert

struct AlertUtility {
    
    static func showToast(with: String, duration: TimeInterval = 1) {
        let alert = UIAlertController(title: "", message: with, preferredStyle: .actionSheet)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alert.dismiss(animated: true, completion: nil)
        }
        
        UIApplication.topViewController!.present(alert, animated: true, completion: nil)
        
    }
    
    static func dismissActionSheet(alert: UIAlertController) {
        alert.dismiss(animated: true, completion: nil)
    }
    
    static func showAlertWith(message: String, isConditional: Bool = false, okStr: String = "OK", cancelStr: String = "CANCEL", viewController: UIViewController = UIApplication.topViewController ?? UIViewController(), completion: @escaping AlertResponse) {
        
        let alertVC = UIAlertController(title: AppName, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okStr, style: .default) { _ in
            completion(true)
        }
        
        let cancelAction = UIAlertAction(title: cancelStr, style: .cancel) { _ in
            completion(false)
        }
        
        alertVC.addAction(okAction)
        if isConditional {
            alertVC.addAction(cancelAction)
        }
        
        viewController.present(alertVC, animated: true, completion: nil)
    }
    
    static func showAlertWith(message: String, isConditional: Bool = false, okStr: String = "OK", cancelStr: String = "CANCEL") {

        let alertVC = UIAlertController(title: AppName, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: okStr, style: .default, handler: nil)

        let cancelAction = UIAlertAction(title: cancelStr, style: .cancel, handler: nil)

        alertVC.addAction(okAction)
        if isConditional {
            alertVC.addAction(cancelAction)
        }

        UIApplication.topViewController?.present(alertVC, animated: true, completion: nil)
    }
}

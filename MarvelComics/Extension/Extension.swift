//
//  Extension+UITableView.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 19/03/20.
//  Copyright © 2020 Puneet Mahajan. All rights reserved.
//

import UIKit
import IHProgressHUD
import BasicSetup

// Extension for view controller identifier
extension UIViewController {
    
    public static var identifier: String {
        get {
            return "\(self)"
        }
    }
    
    public func hideKeyboard() {
        UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
    }
}

public extension UIView {
    
    var nibName: String {
        get {
            return String(describing: type(of: self))
        }
    }
    
    func getNibFile() -> UIView? {
        
        let bundle = Bundle.main
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as? UIView
    }
    
}


extension UIApplication {
    
    static func hideKeyboard() {
        UIApplication.topViewController?.view.endEditing(true)
    }
    
    class var topViewController: UIViewController? {
        get {
            return self.getTopViewController(controller: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController)
        }
    }
    
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    private class func getTopViewController(controller: UIViewController?) -> UIViewController? {
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopViewController(controller: selected)
            }
        }
        else if let presented = controller?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        
        else if let presented = controller as? UINavigationController {
            return getTopViewController(controller: presented.visibleViewController)
        }
        return controller
    }
}


extension IHProgressHUD {
    
    static func showLoader() {
        DispatchQueue.main.async {
            IHProgressHUD.show()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    static func hideLoader() {
        DispatchQueue.main.async {
            IHProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}


extension UIViewController {
    
    func showToast(message: String) {
        
        showToast(message: message.localized(), applySystemTheme: false)
    }
}

//
//  VC+Ext.swift
//  practice
//
//  Created by aycan duskun on 15.03.2023.
//

import UIKit

extension UIViewController {
    
    func presentSPAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = SPAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

//
//  AlertManager.swift
//  RickAndMorty
//
//  Created by aleksandre on 26.05.22.
//

import UIKit


struct AlertManager {
    enum AlertType {
        case networkError
    }

    static func initializeAlert(show alert: AlertType, on targetVC: UIViewController) {
        switch alert {
        case .networkError:
            let alert = UIAlertController(title: "No Internet Connection", message: "Connect to the internet and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            targetVC.present(alert, animated: true)
        }
    }
}

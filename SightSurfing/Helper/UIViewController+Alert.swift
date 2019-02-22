//
//  UIViewController+Alert.swift
//  GithubChat
//
//  Created by ShihTing on 2019/02/01.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

protocol AlertDisplayable {
    /// Display a simple notifying-style alert
    func showAlert(title: String, message: String)
}

extension AlertDisplayable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

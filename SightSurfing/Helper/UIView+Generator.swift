//
//  UIView+Generator.swift
//  GithubChat
//
//  Created by Neo on 2019/1/28.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

extension UIView {

    /// Generate a subview and set the translatesAutoresizingMaskIntoConstraints = false for autolayout
    func generateSubview<T: UIView>() -> T {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

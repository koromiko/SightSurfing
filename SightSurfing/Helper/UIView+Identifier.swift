//
//  UIView+Identifier.swift
//  GithubChat
//
//  Created by Neo on 2019/1/28.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

protocol ClassLevelIdentifiable {
    static var uniqueIdentifier: String { get }
}

extension UITableViewCell: ClassLevelIdentifiable {
    static var uniqueIdentifier: String {
        return String(describing: self)
    }
}

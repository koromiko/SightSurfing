//
//  NSLayoutConstraint+Helper.swift
//  GithubChat
//
//  Created by Neo on 2019/1/28.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(rawValue: priority)
        return self
    }
}

extension Array where Element: NSLayoutConstraint {
    func activate() {
        for constraint in self {
            constraint.isActive = true
        }
    }

    func withPriority(_ priority: Float) -> [NSLayoutConstraint] {
        return self.map {
            $0.withPriority(priority)
        }
    }
}

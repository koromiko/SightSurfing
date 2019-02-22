//
//  UIView+Autolayout.swift
//  GithubChat
//
//  Created by Neo on 2019/1/28.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIView {

    /// generate constraints to superview with given padding setting. Returned constraints are not activated. Given no padding infers to fully snap to superview without padding.
    func constraints(snapTo superview: UIView, top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        var (topConstant, leftConstant, bottomConstant, rightConstant) = (top, left, bottom, right)

        if top == nil && left == nil && bottom == nil && right == nil {
            topConstant = 0.0
            leftConstant = 0.0
            bottomConstant = 0.0
            rightConstant = 0.0
        }

        if let top = topConstant {
            constraints.append(self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top))
        }
        if let left = leftConstant {
            constraints.append(self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left))
        }
        if let bottom = bottomConstant {
            constraints.append(self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom))
        }
        if let right = rightConstant {
            constraints.append(self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -right))
        }

        return constraints
    }

    /// Return width/height constraints
    func constraints(width: CGFloat? = nil, height: CGFloat? = nil) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if let width = width {
            constraints.append(self.widthAnchor.constraint(equalToConstant: width))
        }
        if let height = height {
            constraints.append(self.heightAnchor.constraint(equalToConstant: height))
        }
        return constraints
    }

}

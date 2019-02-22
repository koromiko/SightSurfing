//
//  PhotoListFooterLoadingView.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/20.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

class PhotoListFooterLoadingView: UIView, ClassLevelIdentifiable {
    static var uniqueIdentifier: String {
        return String(describing: self)
    }

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicator)
        indicator.startAnimating()
        indicator.hidesWhenStopped = false
        return indicator
    }()

    init() {
        super.init(frame: .zero)
        [loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)].activate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        loadingIndicator.startAnimating()
    }
}

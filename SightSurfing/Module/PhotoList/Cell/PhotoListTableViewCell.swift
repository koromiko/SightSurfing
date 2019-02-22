//
//  PhotoListTableViewCell.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/19.
//  Copyright © 2019 STH. All rights reserved.
//

import UIKit

class PhotoListTabelViewCell: UITableViewCell {

    lazy var label: UILabel = {
        let label: UILabel = contentView.generateSubview()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.constraints(snapTo: contentView, bottom: 10, right: 10).activate()
        label.constraints(width: 45).activate()
        return label
    }()

    lazy var mainImageView: UIImageView = {
        let imageView: UIImageView = contentView.generateSubview()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.constraints(snapTo: contentView).activate()
        imageView.constraints(height: 200).withPriority(999).activate()
        return imageView
    }()

    func setup(viewModel: PhotoListCellViewModel) {
        mainImageView.image = nil
        mainImageView.setupImage(with: viewModel.photoUrl)
        label.text = viewModel.indexString
    }

}

//
//  PhotoListCellViewModel.swift
//  SightSurfing
//
//  Created by Neo on 2019/2/21.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

struct PhotoListCellViewModel {
    var photoUrl: String
    var indexString: String
}

class PhotoListViewModel {
    var photoCellViewModels: [PhotoListCellViewModel] = []
    var insertCellAtIndexPaths: (([IndexPath]) -> Void)?
    var isLoading = Observable(false)
}

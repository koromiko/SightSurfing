//
//  Observable.swift
//  GithubChat
//
//  Created by Neo on 2019/1/29.
//  Copyright © 2019 STH. All rights reserved.
//

import Foundation

/// Data wrapper for observing the value changes
class Observable<T> {
    /// The value container
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
                self.valueChangedHotStart?(self.value)
            }
        }
    }

    /// Assign this with a closure to observe the value changes, note that this is a cold signal, which won't be fired by closure assignement
    var valueChanged: ((T) -> Void)?

    /// This closure will be triggered when the value updated and when closure is assigned
    var valueChangedHotStart: ((T) -> Void)? {
        didSet {
            valueChangedHotStart?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
}

/**
 Observable for array that one might be able to receive the changed index for the array

 - Description:
 By assigning the valueChanged and dataReloaded to get the value update of the array. This object could be used as an collection, like subscription get/set and filter/map, etc. In addition, append, insert, and remove are also supported
 - Data:
 To reload the whole array, use reloadData(_ values: [T])
*/
class ArrayObservable<T>: Collection, RangeReplaceableCollection {
    typealias Element = T
    typealias Index = Int

    /// The manipulation type to the arrry
    enum Action {
        case insert
        case remove
        case reload
    }

    private var values: [T]

    /// Observing single value changes
    var valueChanged: ((Int, Action) -> Void)?

    /// Observing the whole array update
    var dataReloaded: (() -> Void)?

    required init() {
        values = []
    }

    // MARK: Collection Conformation
    var startIndex: Int {
        return values.startIndex
    }

    var endIndex: Int {
        return values.endIndex
    }

    func index(after i: Int) -> Int {
        return values.index(after: i)
    }

    subscript(position: Int) -> T {
        get {
            return values[position]
        }
        set(newValue) {
            values[position] = newValue
            valueChanged?(position, .reload)
        }
    }

    // MARK: Data Manipulation

    func append(_ newElement: T) {
        values.append(newElement)
        valueChanged?(values.count-1, .insert)
    }

    func remove(at position: Int) -> T {
        let value = values.remove(at: position)
        valueChanged?(position, .remove)
        return value
    }

    func insert(_ newElement: T, at i: Int) {
        values.insert(newElement, at: i)
        valueChanged?(i, .insert)
    }

    /// Update the whole array
    func reloadData(_ values: [T]) {
        self.values = values
        dataReloaded?()
    }

}

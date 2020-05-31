//
//  Collection+Safety.swift
//  GitApi
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return safeGet(atIndex: index)
    }

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    func safeGet(atIndex index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    ///Little sugar to avoid negations
    var hasElements: Bool {
        return self.isEmpty == false
    }

}

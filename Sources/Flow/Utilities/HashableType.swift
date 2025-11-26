//
//  File.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation

public protocol HashableType: IdentifiableType, Hashable { }

extension HashableType {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

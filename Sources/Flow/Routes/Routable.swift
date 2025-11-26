//
//  Routable.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

public protocol Routable: HashableType {
    var id: ID { get }
    var navigationType: NavigationType { get }
    var body: any View { get }
}

extension Routable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

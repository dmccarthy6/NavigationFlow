//
//  Routable.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

public protocol Routable: Hashable, Identifiable {
    associatedtype Screen: View
    var id: ID { get }
    var navigationType: NavigationType { get }

    @MainActor
    var body: Screen { get }
}

extension Routable {
    public var navigationType: NavigationType { .push }
}

extension Routable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

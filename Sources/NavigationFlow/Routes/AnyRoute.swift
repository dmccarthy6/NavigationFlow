//
//  AnyRoute.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

/// Type erased structure that enables abstract navigation. This
/// is used internally and not intended for use outside NavigationFlow.
public struct AnyRoute: Hashable, Identifiable {
    public let id: AnyHashable
    public var navigationType: NavigationType
    public let body: any View

    private let typeId: ObjectIdentifier
    private let wrapped: any Routable
    private let equals: (any Routable) -> Bool

    @MainActor
    public init<Route: Routable>(_ route: Route) {
        self.id = AnyHashable(route.id)
        self.typeId = ObjectIdentifier(Route.self)
        self.wrapped = route
        self.navigationType = route.navigationType
        self.equals = { other in
            guard let otherWrapped = other as? Route else { return false }
            return route == otherWrapped
        }
        self.body = route.body
    }

    public func asType<Route: Routable>(_ type: Route.Type) -> Route? {
        wrapped as? Route
    }

    public func isType<Route: Routable>(_ type: Route.Type) -> Bool {
        ObjectIdentifier(type) == typeId
    }

    public func isType<Route: Routable>(
        _ type: Route.Type,
        where condition: (Route) -> Bool
    ) -> Bool {
        guard let cast = asType(type) else { return false }
        return condition(cast)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(typeId)
        hasher.combine(wrapped)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.equals(rhs.wrapped)
    }
}

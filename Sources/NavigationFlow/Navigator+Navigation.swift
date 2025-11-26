//
//  Navigator+Navigation.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation

public extension Navigator {
    /// Adds the specified route to the top of the navigation stack.
    func push(_ route: any Routable) {
        stack.append(AnyRoute(route))
    }

    func push(_ routes: [any Routable]) {
        routes.forEach { route in
            push(route)
        }
    }

    /// Remove the route at the top of the navigation stack. If there are no routes
    /// calling this method has no effect.
    func pop() {
        stack.removeLast()
    }

    /// Removes all routes from the navigation stack. This will leave only
    /// the root route visible.
    func popToRoot() {
        stack.removeAll()
    }

    /// Removes the specified number of routes off the top of the navigation stack. If the
    /// count is less than zero, no operations are performed. If the count is greater than the
    /// number of routes currently in the stack, all routes will be removed.
    func pop(_ count: Int) {
        guard count > 0 else { return }
        guard count <= stack.count else {
            stack.removeAll()
            return
        }
        stack.removeLast(count)
    }

    func popTo<Route: Routable>(route type: Route.Type) {
        var desiredIndex: Int?

        for (index, route) in stack.reversed().enumerated() {
            if route.isType(type) {
                desiredIndex = index
                break
            }
        }

        if let desiredIndex {
            pop(desiredIndex)
        } else if root.isType(type) {
            popToRoot()
        }
    }

    func popTo<Route: Routable>(
        type: Route.Type,
        where condition: (Route) -> Bool
    ) {
        var foundRouteIndex: Int?

        for (index, route) in stack.reversed().enumerated() {
            if let basedRoute = route.asType(Route.self), condition(basedRoute) {
                foundRouteIndex = index
                break
            }
        }
        
        if let foundRouteIndex {
            pop(foundRouteIndex)
        } else if let route = root.asType(Route.self), condition(route) {
            popToRoot()
        }
    }

    func replace(with routes: [any Routable]) {
        let routes = routes.map { AnyRoute($0) }
        stack = routes
    }
}

//
//  Navigator+Presentation.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import SwiftUI

public extension Navigator {

    var presentedNavigator: Navigator? {
        presentedRoute?.navigator
    }

    var topNavigator: Navigator {
        var top: Navigator = self
        while let next = top.presentedRoute?.navigator {
            top = next
        }
        return top
    }

    var bottomNavigator: Navigator {
        var bottom: Navigator = self
        while let next = bottom.parent {
            bottom = next
        }
        return bottom
    }

    @discardableResult
    func present(_ route: any Routable, _ onDismiss: OptionalClosure = nil) -> Navigator {
        let navigator = Navigator(root: route, parent: self)

        presentedRoute = PresentedRoute(
            navigator: navigator,
            navigationType: route.navigationType,
            route: route,
            onDismiss: onDismiss
        )

        return navigator
    }

    func dismiss() {
        presentedRoute?.navigator.parent = nil
        presentedRoute = nil
    }

    func dismiss<Route: Routable>(to type: Route.Type) {
        var current: Navigator? = parent

        while let next = current?.parent {
            if next.root.isType(type) {
                next.dismiss()
                return
            }
            current = next
        }
    }

    func dismiss<Route: Routable>(to type: Route.Type, where condition: (Route) -> Bool) {
        var current: Navigator? = parent

        while let next = current?.parent {
            if let route = next.root.asType(type), condition(route) {
                next.dismiss()
                return
            }
            current = next
        }
    }

    func dismissAll() {
        bottomNavigator.dismiss()
    }
}

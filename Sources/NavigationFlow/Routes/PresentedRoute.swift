//
//  PresentedRoute.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation

@MainActor
public struct PresentedRoute {
    public let navigator: Navigator
    public let navigationType: NavigationType
    public let route: any Routable
    public let onDismiss: OptionalClosure

    var id: AnyHashable {
        navigator.root.id
    }
}

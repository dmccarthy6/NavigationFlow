//
//  Navigator.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

@MainActor
@Observable
public final class Navigator {
    @ObservationIgnored
    public weak var parent: Navigator?

    private(set) public var root: AnyRoute
    public var stack: [AnyRoute] = []
    public var presentedRoute: PresentedRoute?

    public convenience init(
        root: any Routable = EmptyRoute(),
        parent: Navigator? = nil
    ) {
        self.init(root: AnyRoute(root), parent: parent)
    }

    public init(
        root: AnyRoute,
        parent: Navigator?
    ) {
        self.root = root
        self.parent = parent
    }

    public func setRoot(_ route: any Routable) {
        root = AnyRoute(route)
    }

    internal func isPresenting(_ type: PresentationType) -> Binding<Bool> {
        Binding<Bool> { [weak self] in
            guard let currentType = self?.presentedRoute?.navigationType.presentationType else {
                return false
            }
            return currentType == type
        } set: { [weak self] newValue in
            guard let self, !newValue else {
                return
            }
            self.presentedRoute = nil
        }
    }
}

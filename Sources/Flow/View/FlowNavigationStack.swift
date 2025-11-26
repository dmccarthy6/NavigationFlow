//
//  SwiftUINavigationStack.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import SwiftUI

public struct SwiftUINavigationStack: View {
    @State private var navigator: Navigator

    public init(route: any Routable) {
        navigator = .init(root: route)
    }

    public init(navigator: Navigator) {
        self.navigator = navigator
    }

    public var body: some View {
        NavigationStack(path: $navigator.stack) {
            AnyView(navigator.root.body)
                .id(navigator.root.id)
                .navigationDestination(for: AnyRoute.self) { route in
                    AnyView(route.body)
                        .id(route.id)
                }
        }
        .sheet(
            isPresented: navigator.isPresenting(.sheet()),
            onDismiss: navigator.presentedRoute?.onDismiss,
            content: {
                modalView()
            })
        .fullScreenCover(
            isPresented: navigator.isPresenting(.fullScreen),
            onDismiss: navigator.presentedRoute?.onDismiss
        ) {
            modalView()

        }
    }

    @ViewBuilder
    private func modalView() -> some View {
        if let presentedRoute = navigator.presentedRoute {
            let detents = presentedRoute.navigationType.presentationType?.detents
            SwiftUINavigationStack(route: presentedRoute.route)
                .presentationDetents(detents ?? .init())
        }
    }
}

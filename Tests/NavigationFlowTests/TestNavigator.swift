//
//  TestNavigator.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 11/26/25.
//

import NavigationFlow
import Testing

@MainActor
struct TestNavigator {

    @Test func testCreation() async throws {
        let navigator = Navigator()

        #expect(navigator.root.isType(EmptyRoute.self),
                "Expected navigator to hvae an empty route when created")
        #expect(navigator.stack.count == 0,
                "Expected a navigator to have no routes on init")
        #expect(navigator.presentedRoute == nil,
                "Expect navigator modal to be nil on creation.")
        #expect(navigator.parent == nil,
                "Expect navigator parent to be nil on creation.")
    }

    @Test func testSettingRoute() {
        let navigator = Navigator()
        let identifier = 123456

        navigator.setRoot(PushRoute(identifier: identifier))

        #expect(navigator.root.isType(PushRoute.self), "Expected the route to be a PushRoute")
        #expect(navigator.root.isType(PushRoute.self) {
            $0.identifier == identifier
        }, "Expected route to have an identifier of: \(identifier)")
    }
}

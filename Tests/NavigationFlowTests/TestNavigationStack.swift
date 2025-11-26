//
//  TestNavigationStack.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 11/26/25.
//

import Flow
import Testing

@MainActor
struct TestNavigationStack {
    @Test func testPushSingleRoute() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 1234))

        navigator.push(ModalRoute(identifier: 5678, detent: .large))

        #expect(navigator.stack.count == 1, "Expected 2 but got \(navigator.stack.count)")

        let pushedRoute = navigator.stack.first?.asType(ModalRoute.self)

        #expect(pushedRoute?.identifier == 5678, "Expected")
    }

    @Test func pushMultipleRoutes() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push(PushRoute(identifier: 1))
        navigator.push(PushRoute(identifier: 2))
        navigator.push(PushRoute(identifier: 3))
        
        #expect(navigator.stack.count == 3, "Expected 3 but got \(navigator.stack.count)")

        let firstRoute = navigator.stack.first?.asType(PushRoute.self)
        #expect(firstRoute?.identifier == 1, "Expected a first route with an identifer of 1")

        let secondRoute = navigator.stack[1].asType(PushRoute.self)
        #expect(secondRoute?.identifier == 2, "Expected a second route with an identifer of 2")

        let thirdRoute = navigator.stack[2].asType(PushRoute.self)
        #expect(thirdRoute?.identifier == 3, "Expected a third route with an identifer of 3")
    }

    @Test func pop() {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push(PushRoute(identifier: 1))
        navigator.push(PushRoute(identifier: 2))
        navigator.push(PushRoute(identifier: 3))

        let originalLast = navigator.stack.last?.asType(PushRoute.self)
        #expect(originalLast?.identifier == 3, "Expected the last route to have an identifier of 3")
        
        navigator.pop()
        
        let newLast = navigator.stack.last?.asType(PushRoute.self)
        #expect(newLast?.identifier == 2, "Expected the last route to have an identifier of 2 after popping")
    }

    @Test func popTo() {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push(PushRoute(identifier: 1))
        navigator.push(PushRoute(identifier: 2))
        navigator.push(PushRoute(identifier: 3))

        navigator.pop(2)

        let lastRoute = navigator.stack.last?.asType(PushRoute.self)

        #expect(lastRoute?.identifier == 1, "Expected the last route with an id of 1 after pop")
    }

    @Test func popToRoot() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push(PushRoute(identifier: 1))
        navigator.push(PushRoute(identifier: 2))
        navigator.push(PushRoute(identifier: 3))

        navigator.popToRoot()

        #expect(navigator.stack.count == 0, "Expected the navigation stack to be empty after popping to root.")
        #expect(navigator.root.isType(PushRoute.self), "Expected the route to be a PushRoute.")
    }

    @Test func popToNegativeValue() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push([
            PushRoute(identifier: 1),
            PushRoute(identifier: 2),
            PushRoute(identifier: 3),
            PushRoute(identifier: 4),
        ])

        navigator.pop(-3)

        #expect(navigator.stack.count == 4, "Expected 4 routes after attempting to pop a negative value.")
    }

    @Test func popToCountExceedingValues() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push([
            PushRoute(identifier: 1),
            PushRoute(identifier: 2),
            PushRoute(identifier: 3),
            PushRoute(identifier: 4)
        ])

        navigator.pop(500)

        #expect(navigator.stack.count == 0, "Expected 4 routes after popping to count exceeding stack count.")
    }

    @Test func testReplacingRoutes() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push([
            PushRoute(identifier: 1),
            PushRoute(identifier: 2),
            PushRoute(identifier: 3),
            PushRoute(identifier: 4),
        ])

        let lastRouteId = navigator.stack.last?.asType(PushRoute.self)?.identifier
        #expect(navigator.stack.count == 4, "Expected 4 routes after initial push.")
        #expect(lastRouteId == 4, "Expected the last route to have an id of 4.")

        navigator.replace(with: [
            PushRoute(identifier: 6),
            PushRoute(identifier: 7),
            PushRoute(identifier: 8),
        ])

        let updatedLastRouteId = navigator.stack.last?.asType(PushRoute.self)?.identifier
        #expect(navigator.stack.count == 3, "Expected only three routes in the updated stack.")
        #expect(updatedLastRouteId == 8, "Expected the updated last route to have an id of 8.")
    }

    @Test func testPopToType() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push([
            PushRoute(identifier: 1),
            CalendarRoute(identifier: 2),
            PushRoute(identifier: 3),
            PushRoute(identifier: 4),
        ])

        navigator.popTo(route: CalendarRoute.self)
        let lastRoute = navigator.stack.last?.asType(CalendarRoute.self)

        #expect(navigator.stack.count == 2, "Expected the stack to have 2 routes after popping to type.")
        #expect(lastRoute?.identifier == 2, "Expected the popped to type to have an id of 2")
    }

    @Test func testPopToTypeWhere() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.push([
            PushRoute(identifier: 1),
            CalendarRoute(identifier: 2),
            CalendarRoute(identifier: 3),
            PushRoute(identifier: 4),
        ])

        navigator.popTo(type: CalendarRoute.self) { route in
            route.identifier == 2
        }

        let lastRoute = navigator.stack.last?.asType(CalendarRoute.self)

        #expect(navigator.stack.count == 2, "Expected the stack to have 3 routes after popping to type.")
        #expect(lastRoute?.identifier == 2, "Expected the popped to type to have an id of 3")
    }
}

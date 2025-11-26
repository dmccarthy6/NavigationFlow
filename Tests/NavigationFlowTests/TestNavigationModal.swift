//
//  TestNavigationModal.swift
//  Flow
//
//  Created by Dylan  on 11/26/25.
//

import NavigationFlow
import Testing

@MainActor
struct TestNavigationModal {

    @Test func testModalPresentation() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.present(CalendarRoute(identifier: 1))

        #expect(navigator.stack.count == 0, "Expected the navigator stack to be empty when presenting a route.")

        let modal = navigator.presentedRoute
        #expect(modal != nil, "Expected the navigator's presented route to exist.")
        #expect(modal?.navigator.parent === navigator, "Expected the presented routes parent navigator to be \(navigator).")
    }

    @Test func testModalDismissal() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        navigator.present(CalendarRoute(identifier: 1))
        navigator.dismiss()

        #expect(navigator.presentedRoute == nil, "Expected the presented route to be nil after dismissal.")
    }

    @Test func testMultipleModalPresentations() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(ModalRoute(identifier: 2, detent: .medium))
        let thirdNavigator = secondNavigator.present(ModalRoute(identifier: 3, detent: .large))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        let firstNavigatorRoot = firstNavigator.root
        #expect(firstNavigatorRoot.isType(CalendarRoute.self))
        #expect(firstNavigatorRoot.asType(CalendarRoute.self)?.identifier == 1)
        #expect(firstNavigator.parent === navigator)

        let secondNavigatorRoot = secondNavigator.root
        #expect(secondNavigatorRoot.isType(ModalRoute.self))
        #expect(secondNavigatorRoot.asType(ModalRoute.self)?.identifier == 2)
        #expect(secondNavigator.parent === firstNavigator)

        let thirdNavigatorRoot = thirdNavigator.root
        #expect(thirdNavigatorRoot.isType(ModalRoute.self))
        #expect(thirdNavigatorRoot.asType(ModalRoute.self)?.identifier == 3)
        #expect(thirdNavigator.parent === secondNavigator)

        let fourthNavigatorRoot = fourthNavigator.root
        #expect(fourthNavigatorRoot.isType(ModalRoute.self))
        #expect(fourthNavigatorRoot.asType(ModalRoute.self)?.identifier == 4)
        #expect(fourthNavigator.parent === thirdNavigator)
    }

    @Test func testDismissAllModals() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(ModalRoute(identifier: 2, detent: .medium))
        let thirdNavigator = secondNavigator.present(ModalRoute(identifier: 3, detent: .large))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        fourthNavigator.dismissAll()

        #expect(navigator.presentedRoute == nil)
        #expect(firstNavigator.parent == nil)
    }

    @Test func testDismissToType() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(PushRoute(identifier: 2))
        let thirdNavigator = secondNavigator.present(ModalRoute(identifier: 3, detent: .large))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        fourthNavigator.dismiss(to: PushRoute.self)

        #expect(secondNavigator.presentedRoute == nil)
        #expect(thirdNavigator.parent == nil)
    }

    @Test func testDismissToTypeWithValidCondition() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(PushRoute(identifier: 2))
        let thirdNavigator = secondNavigator.present(PushRoute(identifier: 3))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        fourthNavigator.dismiss(to: PushRoute.self) { route in
            route.identifier == 2
        }

        #expect(secondNavigator.presentedRoute == nil)
        #expect(thirdNavigator.parent == nil)
    }

    @Test func testDismissToTypeWithInvalidCondition() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(PushRoute(identifier: 2))
        let thirdNavigator = secondNavigator.present(PushRoute(identifier: 3))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        fourthNavigator.dismiss(to: PushRoute.self) { route in
            route.identifier == 1999999999
        }

        #expect(navigator.topNavigator === fourthNavigator)
        #expect(fourthNavigator.bottomNavigator === navigator)
    }

    @Test func testBottomNavigator() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(PushRoute(identifier: 2))
        let thirdNavigator = secondNavigator.present(PushRoute(identifier: 3))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        #expect(fourthNavigator.bottomNavigator === navigator)
    }

    @Test func testTopNavigator() async throws {
        let navigator = Navigator(root: PushRoute(identifier: 0))

        let firstNavigator = navigator.present(CalendarRoute(identifier: 1))
        let secondNavigator = firstNavigator.present(PushRoute(identifier: 2))
        let thirdNavigator = secondNavigator.present(PushRoute(identifier: 3))
        let fourthNavigator = thirdNavigator.present(ModalRoute(identifier: 4, detent: .medium))

        #expect(navigator.topNavigator === fourthNavigator)
    }
}

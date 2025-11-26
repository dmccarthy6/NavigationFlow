//
//  MockRoutes.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 11/26/25.
//

import NavigationFlow
import SwiftUI

struct PushRoute: Routable {
    let id: UUID = UUID()
    var navigationType: NavigationType = .push
    let identifier: Int

    var body: any View {
        Text("A push route")
    }
}

struct ModalRoute: Routable {
    let id: UUID = UUID()
    var navigationType: NavigationType { .present(.sheet([detent])) }
    let identifier: Int
    let detent: PresentationDetent

    var body: any View {
        Text("Modal route with detents: \(detent)")
    }
}

struct CalendarRoute: Routable {
    let id: UUID = UUID()
    var navigationType: NavigationType = .push
    let identifier: Int

    var body: any View {
        Text("Calendar route")
    }
}

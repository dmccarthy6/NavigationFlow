//
//  EmptyRoute.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

public struct EmptyRoute: Routable {
    public let id = UUID()
    public var navigationType: NavigationType = .push
    public init() {}
    public var body: any View {
        EmptyView()
    }
}

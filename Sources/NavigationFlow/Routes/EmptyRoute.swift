//
//  EmptyRoute.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

@NavigationRoute
public struct EmptyRoute {
    public init() {}
    public var body: EmptyView {
        .init()
    }
}

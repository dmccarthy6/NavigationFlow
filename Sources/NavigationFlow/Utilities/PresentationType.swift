//
//  PresentationType.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation
import SwiftUI

public enum PresentationType {
    case sheet(Set<PresentationDetent>? = nil)
    case fullScreen
}

public extension PresentationType {
    static func == (
        lhs: PresentationType,
        rhs: PresentationType
    ) -> Bool {
        switch (lhs, rhs) {
        case (.sheet, .sheet):
            return true
        case (.fullScreen, .fullScreen):
            return true
        default: return false
        }
    }

    var detents: Set<PresentationDetent>? {
        guard case .sheet(let detents) = self else {
            return nil
        }
        return detents
    }
}

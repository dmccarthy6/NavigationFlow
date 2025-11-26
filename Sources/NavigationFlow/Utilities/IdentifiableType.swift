//
//  File.swift
//  SwiftUINavigator
//
//  Created by Dylan  on 10/27/25.
//

import Foundation

public protocol IdentifiableType: Identifiable { }

extension IdentifiableType {
    public var id: String {
        String(describing: self.self)
    }
}

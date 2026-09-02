//
//  File.swift
//  NavigationFlow
//
//  Created by Dylan  on 11/26/25.
//

import Foundation
import OSLog

struct NavigationLogger {
    let subsystem: String
    let category: String

    var logger: Logger {
        Logger(subsystem: subsystem, category: category)
    }

    init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
    }
}

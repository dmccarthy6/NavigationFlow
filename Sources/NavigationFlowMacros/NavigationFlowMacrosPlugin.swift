//
//  NavigationFlowMacrosPlugin.swift
//  NavigationFlow
//
//  Created by Dylan  on 9/2/26.
//

#if os(macOS)
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct NavigationFlowMacrosPlugin: CompilerPlugin {
    var providingMacros: [any SwiftSyntaxMacros.Macro.Type] = [
        NavigationRouteMacro.self,
    ]
}
#endif

//
//  File.swift
//  NavigationFlow
//
//  Created by Dylan  on 9/2/26.
//


@attached(member, names: named(id))
@attached(extension, conformances: Routable)
public macro NavigationRoute() = #externalMacro(
    module: "NavigationFlowMacros",
    type: "NavigationRouteMacro"
)

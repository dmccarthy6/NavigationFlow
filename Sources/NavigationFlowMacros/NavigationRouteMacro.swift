//
//  NavigationRouteMacro.swift
//  NavigationFlow
//
//  Created by Dylan  on 9/2/26.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct NavigationRouteMacro: MemberMacro, ExtensionMacro {
    // MARK: - Member Macro

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let isIDPresent = declaration.memberBlock.members.contains { member in
            guard let variable = member.decl.as(VariableDeclSyntax.self) else {
                return false
            }

            return variable.bindings.contains { binding in
                binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text == "id"
            }
        }

        guard !isIDPresent else { return [] }
        return ["public let id = UUID()"]
    }

    // MARK: - Extension Macro

    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard let proto = protocols.first else {
            return []
        }

        let declSyntax: DeclSyntax = "extension \(type.trimmed): \(proto.trimmed) { }"
        guard let extensionDecl = declSyntax.as(ExtensionDeclSyntax.self) else { return [] }
        return [extensionDecl]
    }
}

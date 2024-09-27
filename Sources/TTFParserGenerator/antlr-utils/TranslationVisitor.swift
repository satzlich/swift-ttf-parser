// Copyright 2024 satzlich

import Foundation

/// Translate Antlr syntax tree to our syntax tree
final class TranslationVisitor: SpecificationBaseVisitor<SyntaxNode> {
    let idAllocator: SyntaxNodeIdAllocator

    init(_ idAllocator: SyntaxNodeIdAllocator) {
        self.idAllocator = idAllocator
        super.init()
    }

    override func visitSpecification(_ ctx: SpecificationParser.SpecificationContext) -> (any SyntaxNode)? {
        guard let structDeclarationsCtx = ctx.struct_declarations() else {
            return nil
        }

        var structDeclarations: [StructDeclNode] = []

        for i in 0 ..< structDeclarationsCtx.getChildCount() {
            guard let syntax = structDeclarationsCtx.struct_declaration(i)?.accept(self),
                  let structDecl = syntax as? StructDeclNode
            else {
                return nil
            }
            structDeclarations.append(structDecl)
        }
        return SpecificationNode(structDeclarations)
    }

    override func visitStruct_declaration(_ ctx: SpecificationParser.Struct_declarationContext) -> (any SyntaxNode)? {
        // name
        guard let nameText = Self.structNameText(ctx.struct_name())
        else {
            return nil
        }

        // members
        guard let structMembersContext = ctx.struct_body()?.struct_members() else {
            return nil
        }

        var structMembers: [StructMemberNode] = []
        for i in 0 ..< structMembersContext.getChildCount() {
            guard let syntax = structMembersContext.struct_member(i)?.accept(self),
                  let structMember = syntax as? StructMemberNode
            else {
                return nil
            }

            structMembers.append(structMember)
        }

        return StructDeclNode(Identifier(nameText)!, structMembers)
    }

    override func visitStruct_member(_ ctx: SpecificationParser.Struct_memberContext) -> (any SyntaxNode)? {
        guard let syntax = ctx.variable_declaration()?.accept(self),
              let variableDecl = syntax as? VariableDeclNode
        else {
            return nil
        }

        return StructMemberNode(variableDecl)
    }

    override func visitVariable_declaration(_ ctx: SpecificationParser.Variable_declarationContext) -> (any SyntaxNode)? {
        guard let syntax = ctx.type()?.accept(self),
              let type = syntax as? TypeNode
        else {
            return nil
        }

        guard let nameText = Self.variableNameText(ctx.variable_name())
        else {
            return nil
        }

        return VariableDeclNode(Identifier(nameText)!, type)
    }

    override func visitType(_ ctx: SpecificationParser.TypeContext) -> (any SyntaxNode)? {
        if let type = ctx.type() {
            return type.accept(self)
        }
        else if let typeIdentifier = ctx.type_identifier() {
            guard let nameText = Self.typeNameText(typeIdentifier.type_name())
            else {
                return nil
            }
            return TypeNode(SimpleType(Identifier(nameText)!))
        }
        else if let arrayType = ctx.array_type() {
            guard let syntax = arrayType.type()?.accept(self),
                  let type = syntax as? TypeNode,
                  case let .SimpleType(elementType) = type.variant
            else {
                return nil
            }
            return TypeNode(SpecializedArrayType(elementType))
        }
        else {
            return nil
        }
    }

    private static func structNameText(_ ctx: SpecificationParser.Struct_nameContext?) -> String? {
        Self.identifierText(ctx?.identifier())
    }

    private static func typeNameText(_ ctx: SpecificationParser.Type_nameContext?) -> String? {
        Self.identifierText(ctx?.identifier())
    }

    private static func variableNameText(_ ctx: SpecificationParser.Variable_nameContext?) -> String? {
        Self.identifierText(ctx?.identifier())
    }

    private static func identifierText(_ ctx: SpecificationParser.IdentifierContext?) -> String? {
        ctx?.Identifier()?.getText()
    }
}

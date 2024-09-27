// Generated from Spec.g4 by ANTLR 4.13.2
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link SpecParser}.
 */
public protocol SpecListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link SpecParser#specification}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterSpecification(_ ctx: SpecParser.SpecificationContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#specification}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitSpecification(_ ctx: SpecParser.SpecificationContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#declarations}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDeclarations(_ ctx: SpecParser.DeclarationsContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#declarations}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDeclarations(_ ctx: SpecParser.DeclarationsContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDeclaration(_ ctx: SpecParser.DeclarationContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDeclaration(_ ctx: SpecParser.DeclarationContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#struct_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_declaration(_ ctx: SpecParser.Struct_declarationContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#struct_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_declaration(_ ctx: SpecParser.Struct_declarationContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#struct_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_name(_ ctx: SpecParser.Struct_nameContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#struct_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_name(_ ctx: SpecParser.Struct_nameContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#struct_body}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_body(_ ctx: SpecParser.Struct_bodyContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#struct_body}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_body(_ ctx: SpecParser.Struct_bodyContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#struct_members}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_members(_ ctx: SpecParser.Struct_membersContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#struct_members}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_members(_ ctx: SpecParser.Struct_membersContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#struct_member}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_member(_ ctx: SpecParser.Struct_memberContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#struct_member}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_member(_ ctx: SpecParser.Struct_memberContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#variable_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterVariable_declaration(_ ctx: SpecParser.Variable_declarationContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#variable_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitVariable_declaration(_ ctx: SpecParser.Variable_declarationContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#variable_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterVariable_name(_ ctx: SpecParser.Variable_nameContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#variable_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitVariable_name(_ ctx: SpecParser.Variable_nameContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterType(_ ctx: SpecParser.TypeContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitType(_ ctx: SpecParser.TypeContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#array_type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArray_type(_ ctx: SpecParser.Array_typeContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#array_type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArray_type(_ ctx: SpecParser.Array_typeContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#type_identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterType_identifier(_ ctx: SpecParser.Type_identifierContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#type_identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitType_identifier(_ ctx: SpecParser.Type_identifierContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#type_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterType_name(_ ctx: SpecParser.Type_nameContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#type_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitType_name(_ ctx: SpecParser.Type_nameContext)
	/**
	 * Enter a parse tree produced by {@link SpecParser#identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterIdentifier(_ ctx: SpecParser.IdentifierContext)
	/**
	 * Exit a parse tree produced by {@link SpecParser#identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitIdentifier(_ ctx: SpecParser.IdentifierContext)
}
// Generated from Specification.g4 by ANTLR 4.13.2
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link SpecificationParser}.
 */
public protocol SpecificationListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#specification}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterSpecification(_ ctx: SpecificationParser.SpecificationContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#specification}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitSpecification(_ ctx: SpecificationParser.SpecificationContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#declarations}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDeclarations(_ ctx: SpecificationParser.DeclarationsContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#declarations}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDeclarations(_ ctx: SpecificationParser.DeclarationsContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDeclaration(_ ctx: SpecificationParser.DeclarationContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDeclaration(_ ctx: SpecificationParser.DeclarationContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#struct_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_declaration(_ ctx: SpecificationParser.Struct_declarationContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#struct_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_declaration(_ ctx: SpecificationParser.Struct_declarationContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#struct_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_name(_ ctx: SpecificationParser.Struct_nameContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#struct_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_name(_ ctx: SpecificationParser.Struct_nameContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#struct_body}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_body(_ ctx: SpecificationParser.Struct_bodyContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#struct_body}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_body(_ ctx: SpecificationParser.Struct_bodyContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#struct_members}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_members(_ ctx: SpecificationParser.Struct_membersContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#struct_members}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_members(_ ctx: SpecificationParser.Struct_membersContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#struct_member}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterStruct_member(_ ctx: SpecificationParser.Struct_memberContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#struct_member}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitStruct_member(_ ctx: SpecificationParser.Struct_memberContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#variable_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterVariable_declaration(_ ctx: SpecificationParser.Variable_declarationContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#variable_declaration}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitVariable_declaration(_ ctx: SpecificationParser.Variable_declarationContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#variable_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterVariable_name(_ ctx: SpecificationParser.Variable_nameContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#variable_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitVariable_name(_ ctx: SpecificationParser.Variable_nameContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterType(_ ctx: SpecificationParser.TypeContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitType(_ ctx: SpecificationParser.TypeContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#array_type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterArray_type(_ ctx: SpecificationParser.Array_typeContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#array_type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitArray_type(_ ctx: SpecificationParser.Array_typeContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#type_identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterType_identifier(_ ctx: SpecificationParser.Type_identifierContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#type_identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitType_identifier(_ ctx: SpecificationParser.Type_identifierContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#type_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterType_name(_ ctx: SpecificationParser.Type_nameContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#type_name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitType_name(_ ctx: SpecificationParser.Type_nameContext)
	/**
	 * Enter a parse tree produced by {@link SpecificationParser#identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterIdentifier(_ ctx: SpecificationParser.IdentifierContext)
	/**
	 * Exit a parse tree produced by {@link SpecificationParser#identifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitIdentifier(_ ctx: SpecificationParser.IdentifierContext)
}
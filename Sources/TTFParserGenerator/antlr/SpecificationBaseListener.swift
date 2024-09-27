// Generated from Specification.g4 by ANTLR 4.13.2

import Antlr4


/**
 * This class provides an empty implementation of {@link SpecificationListener},
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
open class SpecificationBaseListener: SpecificationListener {
     public init() { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterSpecification(_ ctx: SpecificationParser.SpecificationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitSpecification(_ ctx: SpecificationParser.SpecificationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterDeclarations(_ ctx: SpecificationParser.DeclarationsContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitDeclarations(_ ctx: SpecificationParser.DeclarationsContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterDeclaration(_ ctx: SpecificationParser.DeclarationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitDeclaration(_ ctx: SpecificationParser.DeclarationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStruct_declaration(_ ctx: SpecificationParser.Struct_declarationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStruct_declaration(_ ctx: SpecificationParser.Struct_declarationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStruct_name(_ ctx: SpecificationParser.Struct_nameContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStruct_name(_ ctx: SpecificationParser.Struct_nameContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStruct_body(_ ctx: SpecificationParser.Struct_bodyContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStruct_body(_ ctx: SpecificationParser.Struct_bodyContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStruct_members(_ ctx: SpecificationParser.Struct_membersContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStruct_members(_ ctx: SpecificationParser.Struct_membersContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterStruct_member(_ ctx: SpecificationParser.Struct_memberContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitStruct_member(_ ctx: SpecificationParser.Struct_memberContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterVariable_declaration(_ ctx: SpecificationParser.Variable_declarationContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitVariable_declaration(_ ctx: SpecificationParser.Variable_declarationContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterVariable_name(_ ctx: SpecificationParser.Variable_nameContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitVariable_name(_ ctx: SpecificationParser.Variable_nameContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterType(_ ctx: SpecificationParser.TypeContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitType(_ ctx: SpecificationParser.TypeContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterArray_type(_ ctx: SpecificationParser.Array_typeContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitArray_type(_ ctx: SpecificationParser.Array_typeContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterType_identifier(_ ctx: SpecificationParser.Type_identifierContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitType_identifier(_ ctx: SpecificationParser.Type_identifierContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterType_name(_ ctx: SpecificationParser.Type_nameContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitType_name(_ ctx: SpecificationParser.Type_nameContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterIdentifier(_ ctx: SpecificationParser.IdentifierContext) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitIdentifier(_ ctx: SpecificationParser.IdentifierContext) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func enterEveryRule(_ ctx: ParserRuleContext) throws { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func exitEveryRule(_ ctx: ParserRuleContext) throws { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitTerminal(_ node: TerminalNode) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	open func visitErrorNode(_ node: ErrorNode) { }
}
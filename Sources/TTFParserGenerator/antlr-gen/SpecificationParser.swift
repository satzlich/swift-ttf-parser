// Generated from Specification.g4 by ANTLR 4.13.2
import Antlr4

open class SpecificationParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = SpecificationParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(SpecificationParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, DOT = 1, LPAREN = 2, LCURLY = 3, LBRACK = 4, RPAREN = 5, 
                 RCURLY = 6, RBRACK = 7, COMMA = 8, COLON = 9, SEMI = 10, 
                 LT = 11, GT = 12, ARRAY = 13, STRUCT = 14, Identifier = 15, 
                 WS = 16, Block_comment = 17, Line_comment = 18
	}

	public
	static let RULE_specification = 0, RULE_struct_declarations = 1, RULE_struct_declaration = 2, 
            RULE_struct_name = 3, RULE_struct_body = 4, RULE_struct_members = 5, 
            RULE_struct_member = 6, RULE_variable_declaration = 7, RULE_variable_name = 8, 
            RULE_type = 9, RULE_array_type = 10, RULE_type_identifier = 11, 
            RULE_type_name = 12, RULE_identifier = 13

	public
	static let ruleNames: [String] = [
		"specification", "struct_declarations", "struct_declaration", "struct_name", 
		"struct_body", "struct_members", "struct_member", "variable_declaration", 
		"variable_name", "type", "array_type", "type_identifier", "type_name", 
		"identifier"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'.'", "'('", "'{'", "'['", "')'", "'}'", "']'", "','", "':'", "';'", 
		"'<'", "'>'", "'Array'", "'struct'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "DOT", "LPAREN", "LCURLY", "LBRACK", "RPAREN", "RCURLY", "RBRACK", 
		"COMMA", "COLON", "SEMI", "LT", "GT", "ARRAY", "STRUCT", "Identifier", 
		"WS", "Block_comment", "Line_comment"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	override open
	func getGrammarFileName() -> String { return "Specification.g4" }

	override open
	func getRuleNames() -> [String] { return SpecificationParser.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return SpecificationParser._serializedATN }

	override open
	func getATN() -> ATN { return SpecificationParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return SpecificationParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.13.2", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,SpecificationParser._ATN,SpecificationParser._decisionToDFA, SpecificationParser._sharedContextCache)
	}


	public class SpecificationContext: ParserRuleContext {
			open
			func EOF() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.EOF.rawValue, 0)
			}
			open
			func struct_declarations() -> Struct_declarationsContext? {
				return getRuleContext(Struct_declarationsContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_specification
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitSpecification(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitSpecification(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func specification() throws -> SpecificationContext {
		var _localctx: SpecificationContext
		_localctx = SpecificationContext(_ctx, getState())
		try enterRule(_localctx, 0, SpecificationParser.RULE_specification)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(29)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (_la == SpecificationParser.Tokens.STRUCT.rawValue) {
		 		setState(28)
		 		try struct_declarations()

		 	}

		 	setState(31)
		 	try match(SpecificationParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Struct_declarationsContext: ParserRuleContext {
			open
			func struct_declaration() -> [Struct_declarationContext] {
				return getRuleContexts(Struct_declarationContext.self)
			}
			open
			func struct_declaration(_ i: Int) -> Struct_declarationContext? {
				return getRuleContext(Struct_declarationContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_declarations
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitStruct_declarations(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitStruct_declarations(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func struct_declarations() throws -> Struct_declarationsContext {
		var _localctx: Struct_declarationsContext
		_localctx = Struct_declarationsContext(_ctx, getState())
		try enterRule(_localctx, 2, SpecificationParser.RULE_struct_declarations)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(34) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(33)
		 		try struct_declaration()


		 		setState(36); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while (_la == SpecificationParser.Tokens.STRUCT.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Struct_declarationContext: ParserRuleContext {
			open
			func STRUCT() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.STRUCT.rawValue, 0)
			}
			open
			func struct_name() -> Struct_nameContext? {
				return getRuleContext(Struct_nameContext.self, 0)
			}
			open
			func struct_body() -> Struct_bodyContext? {
				return getRuleContext(Struct_bodyContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_declaration
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitStruct_declaration(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitStruct_declaration(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func struct_declaration() throws -> Struct_declarationContext {
		var _localctx: Struct_declarationContext
		_localctx = Struct_declarationContext(_ctx, getState())
		try enterRule(_localctx, 4, SpecificationParser.RULE_struct_declaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(38)
		 	try match(SpecificationParser.Tokens.STRUCT.rawValue)
		 	setState(39)
		 	try struct_name()
		 	setState(40)
		 	try struct_body()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Struct_nameContext: ParserRuleContext {
			open
			func identifier() -> IdentifierContext? {
				return getRuleContext(IdentifierContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_name
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitStruct_name(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitStruct_name(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func struct_name() throws -> Struct_nameContext {
		var _localctx: Struct_nameContext
		_localctx = Struct_nameContext(_ctx, getState())
		try enterRule(_localctx, 6, SpecificationParser.RULE_struct_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(42)
		 	try identifier()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Struct_bodyContext: ParserRuleContext {
			open
			func LCURLY() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.LCURLY.rawValue, 0)
			}
			open
			func struct_members() -> Struct_membersContext? {
				return getRuleContext(Struct_membersContext.self, 0)
			}
			open
			func RCURLY() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.RCURLY.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_body
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitStruct_body(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitStruct_body(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func struct_body() throws -> Struct_bodyContext {
		var _localctx: Struct_bodyContext
		_localctx = Struct_bodyContext(_ctx, getState())
		try enterRule(_localctx, 8, SpecificationParser.RULE_struct_body)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(44)
		 	try match(SpecificationParser.Tokens.LCURLY.rawValue)
		 	setState(45)
		 	try struct_members()
		 	setState(46)
		 	try match(SpecificationParser.Tokens.RCURLY.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Struct_membersContext: ParserRuleContext {
			open
			func struct_member() -> [Struct_memberContext] {
				return getRuleContexts(Struct_memberContext.self)
			}
			open
			func struct_member(_ i: Int) -> Struct_memberContext? {
				return getRuleContext(Struct_memberContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_members
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitStruct_members(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitStruct_members(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func struct_members() throws -> Struct_membersContext {
		var _localctx: Struct_membersContext
		_localctx = Struct_membersContext(_ctx, getState())
		try enterRule(_localctx, 10, SpecificationParser.RULE_struct_members)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(51)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (_la == SpecificationParser.Tokens.ARRAY.rawValue || _la == SpecificationParser.Tokens.Identifier.rawValue) {
		 		setState(48)
		 		try struct_member()


		 		setState(53)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Struct_memberContext: ParserRuleContext {
			open
			func variable_declaration() -> Variable_declarationContext? {
				return getRuleContext(Variable_declarationContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_member
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitStruct_member(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitStruct_member(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func struct_member() throws -> Struct_memberContext {
		var _localctx: Struct_memberContext
		_localctx = Struct_memberContext(_ctx, getState())
		try enterRule(_localctx, 12, SpecificationParser.RULE_struct_member)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(54)
		 	try variable_declaration()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Variable_declarationContext: ParserRuleContext {
			open
			func type() -> TypeContext? {
				return getRuleContext(TypeContext.self, 0)
			}
			open
			func variable_name() -> Variable_nameContext? {
				return getRuleContext(Variable_nameContext.self, 0)
			}
			open
			func SEMI() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.SEMI.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_variable_declaration
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitVariable_declaration(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitVariable_declaration(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func variable_declaration() throws -> Variable_declarationContext {
		var _localctx: Variable_declarationContext
		_localctx = Variable_declarationContext(_ctx, getState())
		try enterRule(_localctx, 14, SpecificationParser.RULE_variable_declaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(56)
		 	try type()
		 	setState(57)
		 	try variable_name()
		 	setState(58)
		 	try match(SpecificationParser.Tokens.SEMI.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Variable_nameContext: ParserRuleContext {
			open
			func identifier() -> IdentifierContext? {
				return getRuleContext(IdentifierContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_variable_name
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitVariable_name(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitVariable_name(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func variable_name() throws -> Variable_nameContext {
		var _localctx: Variable_nameContext
		_localctx = Variable_nameContext(_ctx, getState())
		try enterRule(_localctx, 16, SpecificationParser.RULE_variable_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(60)
		 	try identifier()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class TypeContext: ParserRuleContext {
			open
			func array_type() -> Array_typeContext? {
				return getRuleContext(Array_typeContext.self, 0)
			}
			open
			func type_identifier() -> Type_identifierContext? {
				return getRuleContext(Type_identifierContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_type
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitType(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitType(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func type() throws -> TypeContext {
		var _localctx: TypeContext
		_localctx = TypeContext(_ctx, getState())
		try enterRule(_localctx, 18, SpecificationParser.RULE_type)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(64)
		 	try _errHandler.sync(self)
		 	switch (SpecificationParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .ARRAY:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(62)
		 		try array_type()

		 		break

		 	case .Identifier:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(63)
		 		try type_identifier()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Array_typeContext: ParserRuleContext {
			open
			func ARRAY() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.ARRAY.rawValue, 0)
			}
			open
			func LT() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.LT.rawValue, 0)
			}
			open
			func type() -> TypeContext? {
				return getRuleContext(TypeContext.self, 0)
			}
			open
			func GT() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.GT.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_array_type
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitArray_type(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitArray_type(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func array_type() throws -> Array_typeContext {
		var _localctx: Array_typeContext
		_localctx = Array_typeContext(_ctx, getState())
		try enterRule(_localctx, 20, SpecificationParser.RULE_array_type)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(66)
		 	try match(SpecificationParser.Tokens.ARRAY.rawValue)
		 	setState(67)
		 	try match(SpecificationParser.Tokens.LT.rawValue)
		 	setState(68)
		 	try type()
		 	setState(69)
		 	try match(SpecificationParser.Tokens.GT.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Type_identifierContext: ParserRuleContext {
			open
			func type_name() -> Type_nameContext? {
				return getRuleContext(Type_nameContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_type_identifier
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitType_identifier(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitType_identifier(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func type_identifier() throws -> Type_identifierContext {
		var _localctx: Type_identifierContext
		_localctx = Type_identifierContext(_ctx, getState())
		try enterRule(_localctx, 22, SpecificationParser.RULE_type_identifier)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(71)
		 	try type_name()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Type_nameContext: ParserRuleContext {
			open
			func identifier() -> IdentifierContext? {
				return getRuleContext(IdentifierContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_type_name
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitType_name(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitType_name(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func type_name() throws -> Type_nameContext {
		var _localctx: Type_nameContext
		_localctx = Type_nameContext(_ctx, getState())
		try enterRule(_localctx, 24, SpecificationParser.RULE_type_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(73)
		 	try identifier()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class IdentifierContext: ParserRuleContext {
			open
			func Identifier() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.Identifier.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_identifier
		}
		override open
		func accept<T>(_ visitor: ParseTreeVisitor<T>) -> T? {
			if let visitor = visitor as? SpecificationVisitor {
			    return visitor.visitIdentifier(self)
			}
			else if let visitor = visitor as? SpecificationBaseVisitor {
			    return visitor.visitIdentifier(self)
			}
			else {
			     return visitor.visitChildren(self)
			}
		}
	}
	@discardableResult
	 open func identifier() throws -> IdentifierContext {
		var _localctx: IdentifierContext
		_localctx = IdentifierContext(_ctx, getState())
		try enterRule(_localctx, 26, SpecificationParser.RULE_identifier)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(75)
		 	try match(SpecificationParser.Tokens.Identifier.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	static let _serializedATN:[Int] = [
		4,1,18,78,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,7,
		7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,1,0,3,0,30,
		8,0,1,0,1,0,1,1,4,1,35,8,1,11,1,12,1,36,1,2,1,2,1,2,1,2,1,3,1,3,1,4,1,
		4,1,4,1,4,1,5,5,5,50,8,5,10,5,12,5,53,9,5,1,6,1,6,1,7,1,7,1,7,1,7,1,8,
		1,8,1,9,1,9,3,9,65,8,9,1,10,1,10,1,10,1,10,1,10,1,11,1,11,1,12,1,12,1,
		13,1,13,1,13,0,0,14,0,2,4,6,8,10,12,14,16,18,20,22,24,26,0,0,67,0,29,1,
		0,0,0,2,34,1,0,0,0,4,38,1,0,0,0,6,42,1,0,0,0,8,44,1,0,0,0,10,51,1,0,0,
		0,12,54,1,0,0,0,14,56,1,0,0,0,16,60,1,0,0,0,18,64,1,0,0,0,20,66,1,0,0,
		0,22,71,1,0,0,0,24,73,1,0,0,0,26,75,1,0,0,0,28,30,3,2,1,0,29,28,1,0,0,
		0,29,30,1,0,0,0,30,31,1,0,0,0,31,32,5,0,0,1,32,1,1,0,0,0,33,35,3,4,2,0,
		34,33,1,0,0,0,35,36,1,0,0,0,36,34,1,0,0,0,36,37,1,0,0,0,37,3,1,0,0,0,38,
		39,5,14,0,0,39,40,3,6,3,0,40,41,3,8,4,0,41,5,1,0,0,0,42,43,3,26,13,0,43,
		7,1,0,0,0,44,45,5,3,0,0,45,46,3,10,5,0,46,47,5,6,0,0,47,9,1,0,0,0,48,50,
		3,12,6,0,49,48,1,0,0,0,50,53,1,0,0,0,51,49,1,0,0,0,51,52,1,0,0,0,52,11,
		1,0,0,0,53,51,1,0,0,0,54,55,3,14,7,0,55,13,1,0,0,0,56,57,3,18,9,0,57,58,
		3,16,8,0,58,59,5,10,0,0,59,15,1,0,0,0,60,61,3,26,13,0,61,17,1,0,0,0,62,
		65,3,20,10,0,63,65,3,22,11,0,64,62,1,0,0,0,64,63,1,0,0,0,65,19,1,0,0,0,
		66,67,5,13,0,0,67,68,5,11,0,0,68,69,3,18,9,0,69,70,5,12,0,0,70,21,1,0,
		0,0,71,72,3,24,12,0,72,23,1,0,0,0,73,74,3,26,13,0,74,25,1,0,0,0,75,76,
		5,15,0,0,76,27,1,0,0,0,4,29,36,51,64
	]

	public
	static let _ATN = try! ATNDeserializer().deserialize(_serializedATN)
}
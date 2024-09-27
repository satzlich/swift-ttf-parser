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
	static let RULE_specification = 0, RULE_declarations = 1, RULE_declaration = 2, 
            RULE_struct_declaration = 3, RULE_struct_name = 4, RULE_struct_body = 5, 
            RULE_struct_members = 6, RULE_struct_member = 7, RULE_variable_declaration = 8, 
            RULE_variable_name = 9, RULE_type = 10, RULE_array_type = 11, 
            RULE_type_identifier = 12, RULE_type_name = 13, RULE_identifier = 14

	public
	static let ruleNames: [String] = [
		"specification", "declarations", "declaration", "struct_declaration", 
		"struct_name", "struct_body", "struct_members", "struct_member", "variable_declaration", 
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
			func declarations() -> DeclarationsContext? {
				return getRuleContext(DeclarationsContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_specification
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterSpecification(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitSpecification(self)
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
		 	setState(31)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (_la == SpecificationParser.Tokens.STRUCT.rawValue) {
		 		setState(30)
		 		try declarations()

		 	}

		 	setState(33)
		 	try match(SpecificationParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class DeclarationsContext: ParserRuleContext {
			open
			func declaration() -> [DeclarationContext] {
				return getRuleContexts(DeclarationContext.self)
			}
			open
			func declaration(_ i: Int) -> DeclarationContext? {
				return getRuleContext(DeclarationContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_declarations
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterDeclarations(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitDeclarations(self)
			}
		}
	}
	@discardableResult
	 open func declarations() throws -> DeclarationsContext {
		var _localctx: DeclarationsContext
		_localctx = DeclarationsContext(_ctx, getState())
		try enterRule(_localctx, 2, SpecificationParser.RULE_declarations)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(36) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(35)
		 		try declaration()


		 		setState(38); 
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

	public class DeclarationContext: ParserRuleContext {
			open
			func struct_declaration() -> Struct_declarationContext? {
				return getRuleContext(Struct_declarationContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_declaration
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterDeclaration(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitDeclaration(self)
			}
		}
	}
	@discardableResult
	 open func declaration() throws -> DeclarationContext {
		var _localctx: DeclarationContext
		_localctx = DeclarationContext(_ctx, getState())
		try enterRule(_localctx, 4, SpecificationParser.RULE_declaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(40)
		 	try struct_declaration()

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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterStruct_declaration(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitStruct_declaration(self)
			}
		}
	}
	@discardableResult
	 open func struct_declaration() throws -> Struct_declarationContext {
		var _localctx: Struct_declarationContext
		_localctx = Struct_declarationContext(_ctx, getState())
		try enterRule(_localctx, 6, SpecificationParser.RULE_struct_declaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(42)
		 	try match(SpecificationParser.Tokens.STRUCT.rawValue)
		 	setState(43)
		 	try struct_name()
		 	setState(44)
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
			func Identifier() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.Identifier.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_struct_name
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterStruct_name(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitStruct_name(self)
			}
		}
	}
	@discardableResult
	 open func struct_name() throws -> Struct_nameContext {
		var _localctx: Struct_nameContext
		_localctx = Struct_nameContext(_ctx, getState())
		try enterRule(_localctx, 8, SpecificationParser.RULE_struct_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(46)
		 	try match(SpecificationParser.Tokens.Identifier.rawValue)

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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterStruct_body(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitStruct_body(self)
			}
		}
	}
	@discardableResult
	 open func struct_body() throws -> Struct_bodyContext {
		var _localctx: Struct_bodyContext
		_localctx = Struct_bodyContext(_ctx, getState())
		try enterRule(_localctx, 10, SpecificationParser.RULE_struct_body)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(48)
		 	try match(SpecificationParser.Tokens.LCURLY.rawValue)
		 	setState(49)
		 	try struct_members()
		 	setState(50)
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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterStruct_members(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitStruct_members(self)
			}
		}
	}
	@discardableResult
	 open func struct_members() throws -> Struct_membersContext {
		var _localctx: Struct_membersContext
		_localctx = Struct_membersContext(_ctx, getState())
		try enterRule(_localctx, 12, SpecificationParser.RULE_struct_members)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(55)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & 40964) != 0)) {
		 		setState(52)
		 		try struct_member()


		 		setState(57)
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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterStruct_member(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitStruct_member(self)
			}
		}
	}
	@discardableResult
	 open func struct_member() throws -> Struct_memberContext {
		var _localctx: Struct_memberContext
		_localctx = Struct_memberContext(_ctx, getState())
		try enterRule(_localctx, 14, SpecificationParser.RULE_struct_member)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(58)
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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterVariable_declaration(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitVariable_declaration(self)
			}
		}
	}
	@discardableResult
	 open func variable_declaration() throws -> Variable_declarationContext {
		var _localctx: Variable_declarationContext
		_localctx = Variable_declarationContext(_ctx, getState())
		try enterRule(_localctx, 16, SpecificationParser.RULE_variable_declaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(60)
		 	try type()
		 	setState(61)
		 	try variable_name()
		 	setState(62)
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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterVariable_name(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitVariable_name(self)
			}
		}
	}
	@discardableResult
	 open func variable_name() throws -> Variable_nameContext {
		var _localctx: Variable_nameContext
		_localctx = Variable_nameContext(_ctx, getState())
		try enterRule(_localctx, 18, SpecificationParser.RULE_variable_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(64)
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
			open
			func LPAREN() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.LPAREN.rawValue, 0)
			}
			open
			func type() -> TypeContext? {
				return getRuleContext(TypeContext.self, 0)
			}
			open
			func RPAREN() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.RPAREN.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_type
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterType(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitType(self)
			}
		}
	}
	@discardableResult
	 open func type() throws -> TypeContext {
		var _localctx: TypeContext
		_localctx = TypeContext(_ctx, getState())
		try enterRule(_localctx, 20, SpecificationParser.RULE_type)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(72)
		 	try _errHandler.sync(self)
		 	switch (SpecificationParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .ARRAY:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(66)
		 		try array_type()

		 		break

		 	case .Identifier:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(67)
		 		try type_identifier()

		 		break

		 	case .LPAREN:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(68)
		 		try match(SpecificationParser.Tokens.LPAREN.rawValue)
		 		setState(69)
		 		try type()
		 		setState(70)
		 		try match(SpecificationParser.Tokens.RPAREN.rawValue)

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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterArray_type(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitArray_type(self)
			}
		}
	}
	@discardableResult
	 open func array_type() throws -> Array_typeContext {
		var _localctx: Array_typeContext
		_localctx = Array_typeContext(_ctx, getState())
		try enterRule(_localctx, 22, SpecificationParser.RULE_array_type)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(74)
		 	try match(SpecificationParser.Tokens.ARRAY.rawValue)
		 	setState(75)
		 	try match(SpecificationParser.Tokens.LT.rawValue)
		 	setState(76)
		 	try type()
		 	setState(77)
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
			open
			func DOT() -> TerminalNode? {
				return getToken(SpecificationParser.Tokens.DOT.rawValue, 0)
			}
			open
			func type_identifier() -> Type_identifierContext? {
				return getRuleContext(Type_identifierContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return SpecificationParser.RULE_type_identifier
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterType_identifier(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitType_identifier(self)
			}
		}
	}
	@discardableResult
	 open func type_identifier() throws -> Type_identifierContext {
		var _localctx: Type_identifierContext
		_localctx = Type_identifierContext(_ctx, getState())
		try enterRule(_localctx, 24, SpecificationParser.RULE_type_identifier)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(79)
		 	try type_name()
		 	setState(82)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (_la == SpecificationParser.Tokens.DOT.rawValue) {
		 		setState(80)
		 		try match(SpecificationParser.Tokens.DOT.rawValue)
		 		setState(81)
		 		try type_identifier()

		 	}


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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterType_name(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitType_name(self)
			}
		}
	}
	@discardableResult
	 open func type_name() throws -> Type_nameContext {
		var _localctx: Type_nameContext
		_localctx = Type_nameContext(_ctx, getState())
		try enterRule(_localctx, 26, SpecificationParser.RULE_type_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(84)
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
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.enterIdentifier(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? SpecificationListener {
				listener.exitIdentifier(self)
			}
		}
	}
	@discardableResult
	 open func identifier() throws -> IdentifierContext {
		var _localctx: IdentifierContext
		_localctx = IdentifierContext(_ctx, getState())
		try enterRule(_localctx, 28, SpecificationParser.RULE_identifier)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(86)
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
		4,1,18,89,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,7,
		7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,14,7,14,
		1,0,3,0,32,8,0,1,0,1,0,1,1,4,1,37,8,1,11,1,12,1,38,1,2,1,2,1,3,1,3,1,3,
		1,3,1,4,1,4,1,5,1,5,1,5,1,5,1,6,5,6,54,8,6,10,6,12,6,57,9,6,1,7,1,7,1,
		8,1,8,1,8,1,8,1,9,1,9,1,10,1,10,1,10,1,10,1,10,1,10,3,10,73,8,10,1,11,
		1,11,1,11,1,11,1,11,1,12,1,12,1,12,3,12,83,8,12,1,13,1,13,1,14,1,14,1,
		14,0,0,15,0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,0,0,79,0,31,1,0,0,0,
		2,36,1,0,0,0,4,40,1,0,0,0,6,42,1,0,0,0,8,46,1,0,0,0,10,48,1,0,0,0,12,55,
		1,0,0,0,14,58,1,0,0,0,16,60,1,0,0,0,18,64,1,0,0,0,20,72,1,0,0,0,22,74,
		1,0,0,0,24,79,1,0,0,0,26,84,1,0,0,0,28,86,1,0,0,0,30,32,3,2,1,0,31,30,
		1,0,0,0,31,32,1,0,0,0,32,33,1,0,0,0,33,34,5,0,0,1,34,1,1,0,0,0,35,37,3,
		4,2,0,36,35,1,0,0,0,37,38,1,0,0,0,38,36,1,0,0,0,38,39,1,0,0,0,39,3,1,0,
		0,0,40,41,3,6,3,0,41,5,1,0,0,0,42,43,5,14,0,0,43,44,3,8,4,0,44,45,3,10,
		5,0,45,7,1,0,0,0,46,47,5,15,0,0,47,9,1,0,0,0,48,49,5,3,0,0,49,50,3,12,
		6,0,50,51,5,6,0,0,51,11,1,0,0,0,52,54,3,14,7,0,53,52,1,0,0,0,54,57,1,0,
		0,0,55,53,1,0,0,0,55,56,1,0,0,0,56,13,1,0,0,0,57,55,1,0,0,0,58,59,3,16,
		8,0,59,15,1,0,0,0,60,61,3,20,10,0,61,62,3,18,9,0,62,63,5,10,0,0,63,17,
		1,0,0,0,64,65,3,28,14,0,65,19,1,0,0,0,66,73,3,22,11,0,67,73,3,24,12,0,
		68,69,5,2,0,0,69,70,3,20,10,0,70,71,5,5,0,0,71,73,1,0,0,0,72,66,1,0,0,
		0,72,67,1,0,0,0,72,68,1,0,0,0,73,21,1,0,0,0,74,75,5,13,0,0,75,76,5,11,
		0,0,76,77,3,20,10,0,77,78,5,12,0,0,78,23,1,0,0,0,79,82,3,26,13,0,80,81,
		5,1,0,0,81,83,3,24,12,0,82,80,1,0,0,0,82,83,1,0,0,0,83,25,1,0,0,0,84,85,
		3,28,14,0,85,27,1,0,0,0,86,87,5,15,0,0,87,29,1,0,0,0,5,31,38,55,72,82
	]

	public
	static let _ATN = try! ATNDeserializer().deserialize(_serializedATN)
}
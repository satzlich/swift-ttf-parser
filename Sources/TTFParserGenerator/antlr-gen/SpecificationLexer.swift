// Generated from Specification.g4 by ANTLR 4.13.2
import Antlr4

open class SpecificationLexer: Lexer {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = SpecificationLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(SpecificationLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let DOT=1, LPAREN=2, LCURLY=3, LBRACK=4, RPAREN=5, RCURLY=6, RBRACK=7, 
            COMMA=8, COLON=9, SEMI=10, LT=11, GT=12, ARRAY=13, STRUCT=14, 
            Identifier=15, WS=16, Block_comment=17, Line_comment=18

	public
	static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public
	static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public
	static let ruleNames: [String] = [
		"DOT", "LPAREN", "LCURLY", "LBRACK", "RPAREN", "RCURLY", "RBRACK", "COMMA", 
		"COLON", "SEMI", "LT", "GT", "ARRAY", "STRUCT", "Identifier", "Identifier_head", 
		"Identifier_character", "Identifier_characters", "WS", "Block_comment", 
		"Line_comment"
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
	func getVocabulary() -> Vocabulary {
		return SpecificationLexer.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.13.2", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, SpecificationLexer._ATN, SpecificationLexer._decisionToDFA, SpecificationLexer._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "Specification.g4" }

	override open
	func getRuleNames() -> [String] { return SpecificationLexer.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return SpecificationLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return SpecificationLexer.channelNames }

	override open
	func getModeNames() -> [String] { return SpecificationLexer.modeNames }

	override open
	func getATN() -> ATN { return SpecificationLexer._ATN }

	static let _serializedATN:[Int] = [
		4,0,18,132,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,
		6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,14,
		7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,1,0,1,
		0,1,1,1,1,1,2,1,2,1,3,1,3,1,4,1,4,1,5,1,5,1,6,1,6,1,7,1,7,1,8,1,8,1,9,
		1,9,1,10,1,10,1,11,1,11,1,12,1,12,1,12,1,12,1,12,1,12,1,13,1,13,1,13,1,
		13,1,13,1,13,1,13,1,14,1,14,3,14,83,8,14,1,15,3,15,86,8,15,1,16,1,16,3,
		16,90,8,16,1,17,4,17,93,8,17,11,17,12,17,94,1,18,4,18,98,8,18,11,18,12,
		18,99,1,18,1,18,1,19,1,19,1,19,1,19,1,19,5,19,109,8,19,10,19,12,19,112,
		9,19,1,19,1,19,1,19,1,19,1,19,1,20,1,20,1,20,1,20,5,20,123,8,20,10,20,
		12,20,126,9,20,1,20,3,20,129,8,20,1,20,1,20,2,110,124,0,21,1,1,3,2,5,3,
		7,4,9,5,11,6,13,7,15,8,17,9,19,10,21,11,23,12,25,13,27,14,29,15,31,0,33,
		0,35,0,37,16,39,17,41,18,1,0,4,49,0,65,90,95,95,97,122,168,168,170,170,
		173,173,175,175,178,181,183,186,188,190,192,214,216,246,248,767,880,5759,
		5761,6157,6159,7615,7680,8191,8203,8205,8234,8238,8255,8256,8276,8276,
		8288,8399,8448,8591,9312,9471,10102,10131,11264,11775,11904,12287,12292,
		12295,12321,12335,12337,55295,63744,64829,64832,64975,65008,65055,65072,
		65092,65095,65533,65536,131069,131072,196605,196608,262141,262144,327677,
		327680,393213,393216,458749,458752,524285,524288,589821,589824,655357,
		655360,720893,720896,786429,786432,851965,851968,917501,917504,983037,
		5,0,48,57,768,879,7616,7679,8400,8447,65056,65071,3,0,0,0,9,13,32,32,1,
		1,10,10,135,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,0,0,7,1,0,0,0,0,9,1,0,0,
		0,0,11,1,0,0,0,0,13,1,0,0,0,0,15,1,0,0,0,0,17,1,0,0,0,0,19,1,0,0,0,0,21,
		1,0,0,0,0,23,1,0,0,0,0,25,1,0,0,0,0,27,1,0,0,0,0,29,1,0,0,0,0,37,1,0,0,
		0,0,39,1,0,0,0,0,41,1,0,0,0,1,43,1,0,0,0,3,45,1,0,0,0,5,47,1,0,0,0,7,49,
		1,0,0,0,9,51,1,0,0,0,11,53,1,0,0,0,13,55,1,0,0,0,15,57,1,0,0,0,17,59,1,
		0,0,0,19,61,1,0,0,0,21,63,1,0,0,0,23,65,1,0,0,0,25,67,1,0,0,0,27,73,1,
		0,0,0,29,80,1,0,0,0,31,85,1,0,0,0,33,89,1,0,0,0,35,92,1,0,0,0,37,97,1,
		0,0,0,39,103,1,0,0,0,41,118,1,0,0,0,43,44,5,46,0,0,44,2,1,0,0,0,45,46,
		5,40,0,0,46,4,1,0,0,0,47,48,5,123,0,0,48,6,1,0,0,0,49,50,5,91,0,0,50,8,
		1,0,0,0,51,52,5,41,0,0,52,10,1,0,0,0,53,54,5,125,0,0,54,12,1,0,0,0,55,
		56,5,93,0,0,56,14,1,0,0,0,57,58,5,44,0,0,58,16,1,0,0,0,59,60,5,58,0,0,
		60,18,1,0,0,0,61,62,5,59,0,0,62,20,1,0,0,0,63,64,5,60,0,0,64,22,1,0,0,
		0,65,66,5,62,0,0,66,24,1,0,0,0,67,68,5,65,0,0,68,69,5,114,0,0,69,70,5,
		114,0,0,70,71,5,97,0,0,71,72,5,121,0,0,72,26,1,0,0,0,73,74,5,115,0,0,74,
		75,5,116,0,0,75,76,5,114,0,0,76,77,5,117,0,0,77,78,5,99,0,0,78,79,5,116,
		0,0,79,28,1,0,0,0,80,82,3,31,15,0,81,83,3,35,17,0,82,81,1,0,0,0,82,83,
		1,0,0,0,83,30,1,0,0,0,84,86,7,0,0,0,85,84,1,0,0,0,86,32,1,0,0,0,87,90,
		7,1,0,0,88,90,3,31,15,0,89,87,1,0,0,0,89,88,1,0,0,0,90,34,1,0,0,0,91,93,
		3,33,16,0,92,91,1,0,0,0,93,94,1,0,0,0,94,92,1,0,0,0,94,95,1,0,0,0,95,36,
		1,0,0,0,96,98,7,2,0,0,97,96,1,0,0,0,98,99,1,0,0,0,99,97,1,0,0,0,99,100,
		1,0,0,0,100,101,1,0,0,0,101,102,6,18,0,0,102,38,1,0,0,0,103,104,5,47,0,
		0,104,105,5,42,0,0,105,110,1,0,0,0,106,109,3,39,19,0,107,109,9,0,0,0,108,
		106,1,0,0,0,108,107,1,0,0,0,109,112,1,0,0,0,110,111,1,0,0,0,110,108,1,
		0,0,0,111,113,1,0,0,0,112,110,1,0,0,0,113,114,5,42,0,0,114,115,5,47,0,
		0,115,116,1,0,0,0,116,117,6,19,0,0,117,40,1,0,0,0,118,119,5,47,0,0,119,
		120,5,47,0,0,120,124,1,0,0,0,121,123,9,0,0,0,122,121,1,0,0,0,123,126,1,
		0,0,0,124,125,1,0,0,0,124,122,1,0,0,0,125,128,1,0,0,0,126,124,1,0,0,0,
		127,129,7,3,0,0,128,127,1,0,0,0,129,130,1,0,0,0,130,131,6,20,0,0,131,42,
		1,0,0,0,10,0,82,85,89,94,99,108,110,124,128,1,0,1,0
	]

	public
	static let _ATN: ATN = try! ATNDeserializer().deserialize(_serializedATN)
}
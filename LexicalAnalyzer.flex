import java.io.*;

%%

%byaccj

%{

	// Armazena uma referencia para o parser
	private Parser yyparser;

	// Construtor recebendo o parser como parametro adicional
	public Yylex(Reader r, Parser yyparser){
		this(r);
		this.yyparser = yyparser;
	}	

%}

NL = \n | \r | \r\n

%%
"classe"	{ return Parser.CLASS; }
"subclasse" { return Parser.SUBCLASS;}
"funcao_principal" { return Parser.MAIN;}
\/\/.*$ { 	yyparser.yylval = new ParserVal(yytext());
			return Parser.COMMENT_LINE;}
"{"			{return Parser.OPEN_KEYS;}
"}"			{return Parser.CLOSE_KEYS;}
"inteiro"	{return Parser.INTEGER;}
"String" 	{return Parser.STRING;}
","			{ return Parser.COMMA;}
"vetor"		{return Parser.ARRAY;}
"[" { return Parser.OPEN_BRACKET;}
"]" { return Parser.CLOSE_BRACKET;}
"real" { return Parser.FLOAT;}
"(" { return Parser.OPEN_PARENTHESES;}
")" { return Parser.CLOSE_PARENTHESES;}
"se" {return Parser.IF;}
"="	{return Parser.EQUALS;}
"!=" {return Parser.NOT_EQUALS;}
">"	{return Parser.GREATER;}
"<"	{return Parser.LESS;}
">=" { return Parser.GREATER_EQUALS;}
"<=" { return Parser.LESS_EQUALS;}
"<-"  {return Parser.ATRIBUITION;}
"+"	{return Parser.PLUS;}
"-"	{return Parser.MINUS;}
"/"	{return Parser.DIVISION;}
"*" { return Parser.MULTIPLICATION;}
"enquanto" { return Parser.WHILE;}
"senao" { return Parser.ELSE;}
"escrever" { return Parser.PRINT;}
"_"  {return Parser.RETURN;}
[.]	{return Parser.DOT;}
"nulo" {return Parser.NULL;}
"para" { return Parser.FOR;}
"ate" { return Parser.UNTIL;}
"passo" { return Parser.PASS;}
"length" { return Parser.LENGTH;}
"trim" 	 { return Parser.TRIM;}
\".*\" {yyparser.yylval = new ParserVal(yytext());
			return Parser.STRING_TO_PRINT;}
[a-zA-Z][a-zA-Z0-9_]*	{ 
		yyparser.yylval = new ParserVal(yytext());
		return Parser.IDENTIFIER;
	}
[-]?[0-9]+(\.[0-9]+)? { yyparser.yylval = new ParserVal(yytext());
		return Parser.NUMBER;}
{NL}|" "|\t  {}

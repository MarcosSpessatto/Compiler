%{
	import java.io.*;
	import java.util.*;
%}



/* BYACC Declarations */
%token CLASS
%token SUBCLASS
%token <sval> IDENTIFIER
%token OPEN_KEYS
%token CLOSE_KEYS
%token INTEGER
%token STRING
%token COMMA
%token ARRAY
%token FLOAT
%token IF
%token WHILE
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token OPEN_PARENTHESES
%token CLOSE_PARENTHESES
%token EQUALS
%token NOT_EQUALS
%token GREATER
%token LESS
%token GREATER_EQUALS
%token LESS_EQUALS
%token ATRIBUITION
%token PLUS
%token MINUS
%token DIVISION
%token MULTIPLICATION
%token RETURN
%token ELSE
%token NULL
%token PRINT
%token FOR
%token UNTIL
%token PASS
%token MAIN
%token DOT
%token LENGTH
%token TRIM
%token <sval> NUMBER
%token <sval> COMMENT_LINE
%token <sval> STRING_TO_PRINT
%type <sval> root
%type <sval> classe
%type <sval> comment
%type <sval> commands
%type <sval> declarations
%type <sval> params
%type <sval> function_commands
%type <sval> function
%type <sval> condition
%type <sval> operand
%type <sval> operator
%type <sval> operation
%type <sval> atribuition
%type <sval> function_variables
%type <sval> math_operator
%type <sval> for_operation
%type <sval> subclass
%type <sval> methods
%type <sval> return_statement
%type <sval> expression
%type <sval> complex_condition
%type <sval> concat

%%
// ROOT
program : root { System.out.println($1); }
	     ;

root : comment root { $$ = $1 + "\n" + $2; }
	 | classe root	   { $$ = $1 + $2; }
	 | subclass root 	{ $$ = $1 + $2;}
	 |					{ $$ = ""; }
		

// CLASS 
classe : CLASS IDENTIFIER OPEN_KEYS commands CLOSE_KEYS { $$ = "\nclass " + $2 + " {"+ $4 + "\n }"; }

// SUBCLASS
subclass : SUBCLASS IDENTIFIER OPEN_KEYS commands CLOSE_KEYS { $$ = "\nprivate class " + $2 + " {" + $4 + "\n }";}
		 | SUBCLASS IDENTIFIER OPEN_KEYS IDENTIFIER CLOSE_KEYS OPEN_KEYS commands CLOSE_KEYS { $$ = "\nprivate class " + $2 + " extends " + $4 + " { " + $7 + "\n }";}

// COMMENTS
comment : COMMENT_LINE	{ $$ = $1; }

//COMMANDS
commands : MAIN OPEN_KEYS function_commands CLOSE_KEYS commands { $$ = "\npublic static void main (String[] args) {\n" + $3 + "\n}" + $5;}
		 | declarations commands { $$ = $1 + ";" + $2 ;}
		 | function commands { $$ = $1 + $2;}
		 | comment commands { $$ = "\n" + $1 + $2;}
		 | {$$ = "";}

// DECLARATIONS ONLY FOR OUT OF METHODS/
declarations : INTEGER IDENTIFIER declarations { $$ = "\nint " + $2 + $3;}
			 | IDENTIFIER IDENTIFIER declarations { $$ = "\n" + $1 + " " +  $2 + "= new " + $1 + "()";}
 			 | ARRAY INTEGER IDENTIFIER OPEN_BRACKET NUMBER CLOSE_BRACKET declarations { $$ = "\nint[] " + $3 + " = new int[" + $5 + "]" + $7;}
 			 | FLOAT IDENTIFIER declarations { $$ = "\nfloat " + $2 + $3;}
 			 | IDENTIFIER declarations { $$ = $1 + ";" + $2;}
 			 | STRING IDENTIFIER declarations { $$ = "\nString " + $2 + $3;}
 			 | COMMA declarations { $$ = "," + $2;}
 			 | { $$ = "";}

// PARAMS FOR FUNCTIONS
params : INTEGER IDENTIFIER params { $$ = "int " + $2 + $3;}
	   | FLOAT IDENTIFIER params { $$ = "float " + $2 + $3;}
	   | COMMA params { $$ = "," + $2;}
	   | IDENTIFIER params { $$ = $1 + $2;}
	   | {$$ = "";}

// FUNCTION DECLARATIONS
function : INTEGER IDENTIFIER OPEN_PARENTHESES params CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS { $$ = "\nint " + $2 + "(" + $4 + ") { \n" + $7 + "\n}";}
		 | FLOAT IDENTIFIER OPEN_PARENTHESES params CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS { $$ = "\nfloat " + $2 + "(" + $4 + ") { \n" + $7 + "\n}";}
		 | NULL IDENTIFIER OPEN_PARENTHESES params CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS { $$ = "\nvoid " + $2 + "(" + $4 + ") { \n" + $7 + "\n}";}

// FUNCTIONS COMMANDS 
function_commands : function_variables function_commands { $$ = $1 + ";" + $2;} 
				  | atribuition function_commands { $$ = $1 + "\n" + $2;}
				  | comment function_commands { $$ = "\n" + $1 + $2;}
				  | IF OPEN_PARENTHESES condition CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS function_commands { $$ = "\nif (" + $3 + ") {\n " + $6 + "\n}" + $8;}
				  | IF OPEN_PARENTHESES condition CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS ELSE OPEN_KEYS function_commands CLOSE_KEYS function_commands { $$ = "\nif (" + $3 + ") {\n " + $6 + "\n}\n else {\n" + $10 + "\n}" + $12;}
				  | WHILE OPEN_PARENTHESES condition CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS function_commands { $$ = "\nwhile (" + $3 + ") {\n " + $6 + "\n}" + $8;}
				  | FOR OPEN_PARENTHESES IDENTIFIER ATRIBUITION NUMBER UNTIL condition PASS for_operation CLOSE_PARENTHESES OPEN_KEYS function_commands CLOSE_KEYS function_commands{$$ = "\nfor(int "+ $3 + "=" + $5 + ";" + $7 + ";" + $9 + ") {\n" + $12 + "\n}" + $14;}
				  | operation function_commands { $$ = $1 + $2;}
				  | methods function_commands { $$ = $1 + $2;}
				  | PRINT OPEN_PARENTHESES STRING_TO_PRINT CLOSE_PARENTHESES function_commands { $$ = "\nSystem.out.print(" + $3 + ");" + $5;}
				  | PRINT OPEN_PARENTHESES IDENTIFIER CLOSE_PARENTHESES function_commands { $$ = "\nSystem.out.print(" + $3 + ");" + $5;}
				  | PRINT OPEN_PARENTHESES concat CLOSE_PARENTHESES function_commands { $$ = "\nSystem.out.print(" + $3 + ");" + $5;}
				  | return_statement function_commands { $$ = $1 + $2;}
				  | {$$ = "";}

//CONCAT STRING TO PRINT
concat : STRING_TO_PRINT PLUS concat { $$ = $1 + " + " + $3;}
	   | operand PLUS concat { $$ = $1 + " + " + $3;}
	   | operand { $$ = $1;}
	   | STRING_TO_PRINT { $$ = $1;}

//RETURN
return_statement :  RETURN operand { $$ = "\nreturn " + $2 +  ";";}
				 | RETURN { $$ = "\nreturn;";}

// VARIABLES FOR A INSIDE FUNCTIONS 
function_variables : INTEGER IDENTIFIER  { $$ = "\nint "  + $2;}
			 	   | IDENTIFIER IDENTIFIER { $$ = "\n" + $1 + " " +  $2 + "= new " + $1 + "()";}
	 			   | ARRAY INTEGER IDENTIFIER OPEN_BRACKET NUMBER CLOSE_BRACKET  { $$ = "\nint[] " + $3 + " = new int[" + $5 + "]";}
	 			   | FLOAT IDENTIFIER  { $$ = "\nfloat " + $2;}
	 			   | IDENTIFIER  { $$ = $1;}
	 			   | STRING IDENTIFIER  { $$ = "\nString " + $2;}
	 			   | COMMA  { $$ = ",";}



// CONDITIONS, FOR A IF, FOR, AND WHILE STATEMENTS /
condition : operand operator operand { $$ = $1 + $2 + $3;}
		  | complex_condition { $$ = $1;}

//COMPOST CONDITIONS WITH IF STATEMENT
complex_condition : OPEN_PARENTHESES complex_condition CLOSE_PARENTHESES { $$ = "(" + $2 + ")";}
			      | operand math_operator complex_condition { $$ = $1 + $2 + $3;}
			      | operand operator complex_condition { $$ = $1 + $2 + $3;}
			      | operand  { $$ = $1 ;}


//ATRIBUITION FOR "FOR", PREVENTS BREAKS LINE /
for_operation : operand ATRIBUITION operand math_operator operand {$$ = $1 + "= " + $3 + $4 + $5;}

//MATH OPERATIONS /
operation : operand ATRIBUITION operand math_operator operand {$$ = "\n" + $1 + "= " + $3 + $4 + $5 + ";\n";}
		  | operand ATRIBUITION expression { $$ = "\n" + $1 + " = " + $3 + ";";}

//COMPOST EXPRESSION WITH CALCULUS
expression : OPEN_PARENTHESES expression CLOSE_PARENTHESES { $$ = "(" + $2 + ")";}
		   | operand math_operator expression { $$ = $1 + $2 + $3;}
		   | NUMBER NUMBER { $$ = $1 + $2;}
		   | operand  { $$ = $1 ;}

//OPERATIONS WITH METHODS 
methods : IDENTIFIER DOT IDENTIFIER ATRIBUITION operand { $$ = "\n" + $1 + "." + $3 + "=" + $5 + ";";}
		| IDENTIFIER DOT IDENTIFIER OPEN_PARENTHESES CLOSE_PARENTHESES { $$ = "\n" + $1 + "." + $3 + "();";}
		| operand ATRIBUITION IDENTIFIER DOT IDENTIFIER OPEN_PARENTHESES CLOSE_PARENTHESES { $$ = "\n" + $1 + "=" + $3 + "." + $5 + "();";}

// OPERANDS 
operand : IDENTIFIER { $$ = $1;}
		| NUMBER	 { $$ = $1;}
		| IDENTIFIER OPEN_BRACKET NUMBER CLOSE_BRACKET { $$ = $1 + "[" + $3 + "]";}
		| IDENTIFIER OPEN_BRACKET IDENTIFIER CLOSE_BRACKET { $$ = $1 + "[" + $3 + "]";}

// OPERATORS
operator : EQUALS { $$ = "==";}
		 | NOT_EQUALS { $$ = "!=";}
		 | GREATER { $$ = ">";}
		 | GREATER_EQUALS { $$ = ">=";}
		 | LESS { $$ = "<";}
		 | LESS_EQUALS { $$ = "<=";}

//MATH OPERATORS
math_operator :  PLUS { $$ = "+";}
			  | MINUS { $$ = "-";}
			  | DIVISION { $$ = "/";}
			  | MULTIPLICATION {$$ = "*";}

// ATRIBUITIONS
atribuition : operand ATRIBUITION operand { $$ = "\n" + $1 + " = " + $3 + ";";}
			| operand ATRIBUITION STRING_TO_PRINT { $$ = "\n" + $1 + " = " + $3 + ";";}
			| operand ATRIBUITION IDENTIFIER DOT LENGTH { $$ = "\n" + $1 + " = " + $3 + ".length();";}
			| operand ATRIBUITION IDENTIFIER DOT TRIM OPEN_PARENTHESES CLOSE_PARENTHESES { $$ = "\n" + $1 + " = " + $3 + ".trim();";}

%%

	// Referencia ao JFlex
	private Yylex lexer;

	/* Interface com o JFlex */
	private int yylex(){
		int yyl_return = -1;
		try {
			yyl_return = lexer.yylex();
		} catch (IOException e) {
			System.err.println("Erro de IO: " + e);
		}
		return yyl_return;
	}

	/* Reporte de erro */
	public void yyerror(String error){
		System.err.println("Error: " + error);
	}

	// Interface com o JFlex eh criado no construtor
	public Parser(Reader r){
		lexer = new Yylex(r, this);
	}

	// Main
	public static void main(String[] args){
		try{ 
			Parser yyparser = new Parser(new FileReader(args[0]));
			yyparser.yyparse();
			} catch (IOException ex) {
				System.err.println("Error: " + ex);
			}
	}

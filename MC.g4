/**
 * Student name:
 * Student ID:
 */
grammar MC;

@lexer::header{
	package mc.parser;
}

@lexer::members{
@Override
public Token emit() {
    switch (getType()) {
    case UNCLOSE_STRING:       
        Token result = super.emit();
        // you'll need to define this method
        throw new UncloseString(result.getText());
        
    case ILLEGAL_ESCAPE:
    	result = super.emit();
    	throw new IllegalEscape(result.getText());

    case ERROR_CHAR:
    	result = super.emit();
    	throw new ErrorToken(result.getText());	

    default:
        return super.emit();
    }
}
}

@parser::header{
	package mc.parser;
}

options{
	language=Java;
}
        
program:;

ID: [_a-zA-Z][_a-zA-Z0-9]*;

//keywords
BOOLEAN: 'boolean';
BREAK: 'break';
CONTINUE: 'continue';
FOR: 'for';
ELSE: 'else';
FLOAT: 'float';
IF: 'if';
INT: 'int';
RETURN: 'return';
VOID: 'void';
REPEAT: 'repeat';
UNTIL: 'until';
TRUE: 'true';
FALSE: 'false';

//operators
//arith
ADDOP: [+-];
MULOP: [*/];
RELAOP: '<'|'<='|'>'|'>=';
EQUALOP: '=='|'!=';
//logic
OROP: '||';
ANDOP: '&&';
NOTOP: '!';
ASSIGNOP: '=';

//seperators
LR: '(';
RR: ')';
LP: '{';
RP: '}';
LB: '[';
RB: ']';
COMMA: ',';
SEMICOLON: ';';

//literals
INTLIT: [0-9]+;
FLOATLIT:[0-9]*'.'[0-9]*|[0-9]*('e'|'E')[0-9]*;

TRUELIT: 'true';
FALSELIT: 'false';

STRINGLIT: '"' (.|ESCSEQ)*? '"';
ESCSEQ: ('\\''b' | '\\''f' | '\\''r''\\''n' |'\\''t' | '\\''\'' | '\\''"'|'\\''\\' );

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines


ERROR_CHAR:[@#$%^~`];
UNCLOSE_STRING: '"' (.| ESCSEQ)*? ;
ILLEGAL_ESCAPE: '"'(.|ESCSEQ)*?NOTESCSEQ;
NOTESCSEQ: '\\'~('b'|'f'| '\'' | '"' | '\\') |'\\''r''\\'~('n');

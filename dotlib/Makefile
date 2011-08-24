ANTLR=java -jar antlr.jar

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"

all : antlr.jar ExprParser.py ExprLexer.py Expr.tokens 

antlr.jar :
	wget http://antlr.org/download/antlr-3.1.3.jar
	ln -s antlr-3.1.3.jar antlr.jar

ExprParser.py : Expr.g
	$(ANTLR) Expr.g

ExprLexer.py : Expr.g
	$(ANTLR) Expr.g

Expr.tokens : Expr.g
	$(ANTLR) Expr.g

Eval.tokens : Eval.g Expr.tokens
	$(ANTLR) Eval.g

Eval.py : Eval.g ExprParser.py ExprLexer.py
	$(ANTLR) Eval.g


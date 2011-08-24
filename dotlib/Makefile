ANTLR=java -jar antlr.jar

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make clean"

all : antlr.jar ExprParser.py ExprLexer.py Expr.tokens Eval.tokens Eval.py

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

clean :
	$(RM) *.pyc
	$(RM) ExprParser.py ExprLexer.py Expr.tokens
	$(RM) Eval.tokens
	$(RM) Eval.py

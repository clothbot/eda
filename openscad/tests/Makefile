
default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make clean"
	@echo "Makefile.STL usage:"
	make -f Makefile.STL usage
	@echo "Makefile.projection usage:"
	make -f Makefile.projection usage

all : test_stl test_projection

test_stl : 
	make -f Makefile.STL all

test_projection : test_stl
	make -f Makefile.projection all

clean :
	make -f Makefile.projection clean
	make -f Makefile.STL clean


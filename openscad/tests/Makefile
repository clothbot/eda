
default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make clean"
	@echo "  make -f Makefile.STL all"
	@echo "  make -f Makefile.projection all"

all : test_stl test_projection

test_stl : 
	make -f Makefile.STL all

test_projection : test_stl
	make -f Makefile.projection all

clean :
	make -f Makefile.projection clean
	make -f Makefile.STL clean


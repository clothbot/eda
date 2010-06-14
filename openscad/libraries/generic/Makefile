OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

default : usage

usage :
	@echo "Usage:"
	@echo "  make all"
	@echo "  make pin_socket.stl"

all : pin_socket.stl

pin_socket.stl :
	$(OPENSCAD) -D pin_socket_render_part=1 -s pin_socket.stl pin_socket.scad

clean :
	$(RM) *.stl

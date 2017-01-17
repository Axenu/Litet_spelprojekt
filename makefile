# Object files to either reference or create

SOURCESGAME=$(wildcard src/*.cpp)
SOURCEFILESGAME = $(SOURCESGAME:src/%=%)

# The executable file that will be created
EXEC = main
# The c++ flags to use for compilation
CXXFLAGS = -Wall
# The c++ compiler to use for compilation
CC = clang++

GAMESDIR=src/
ODIR=build
GAMEOBJECTS = $(addprefix $(ODIR)/, $(SOURCEFILESGAME:.cpp=.o))
lIBDIR=lib/
IDIR=include/

LIB=-lglfw3 -lIL -ltiff -lpng16 -lz -ljasper -ljpeg -llzma -lfreetype -lbz2 -lmng -llcms

#OSX frameworks
FRAMEWORKS=-framework IOKit -framework Cocoa -framework OpenGL -framework CoreVideo


# This section is called on 'make'
# Will call compile, and then call clean
all: $(GAMEOBJECTS)
	$(CC) -L $(lIBDIR) -std=c++11 -o $(EXEC) $^ $(FRAMEWORKS) $(LIB)

$(ODIR)/%.o: $(GAMESDIR)/%.cpp
	$(CC) -I $(IDIR) -std=c++11 -Wno-c++11-long-long -Wall -c -o $@ $<

clean:
	rm -f $(ODIR)/*.o
	rm -f $(ODIR)/*.a
	rm $(EXEC)

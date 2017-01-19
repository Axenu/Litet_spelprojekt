# Object files to either reference or create

GAMESDIR=src/
ifeq ($(OS),Windows_NT)
lIBDIR=lib/Windows/
else
LIBDIR=lib/
endif
IDIR=include/
ODIR=build/

SOURCESGAME=$(wildcard $(GAMESDIR)*.cpp)
SOURCEFILESGAME = $(SOURCESGAME:$(GAMESDIR)%=%)

# The executable file that will be created
EXEC = main
# The c++ flags to use for compilation
CXXFLAGS = -Wall
# The c++ compiler to use for compilation
CC = g++


GAMEOBJECTS = $(addprefix $(ODIR), $(SOURCEFILESGAME:.cpp=.o))

ifeq ($(OS),Windows_NT)
#windows lib
LIB=-lglfw3 -lopengl32 -lgdi32
else
#OSX lib
LIB=-lglfw3 -lIL -ltiff -lpng16 -lz -ljasper -ljpeg -llzma -lfreetype -lbz2 -lmng -llcms
FRAMEWORKS=-framework IOKit -framework Cocoa -framework OpenGL -framework CoreVideo
endif

# This section is called on 'make'
# Will call compile, and then call clean
all: $(GAMEOBJECTS)
	$(CC) -L $(lIBDIR) -std=c++11 -o $(EXEC) $^ $(FRAMEWORKS) $(LIB)

$(ODIR)%.o: $(GAMESDIR)%.cpp
	$(CC) -I $(IDIR) -std=c++11 -Wno-c++11-long-long -Wall -c -o $@ $<

clean:
	rm -rf $(ODIR)*.o


COCOAFLAGS=-framework Foundation
OBJ=ESATMUpdate.o dash.o

all: dash printSelector

ESATMUpdate.o: ESATMUpdate.h ESATMUpdate.m

printSelector.o: printSelector.m 

dash: $(OBJ)
	$(CC) $(COCOAFLAGS) $(OBJ) -o dash

printSelector: ESATMUpdate.o printSelector.o
	$(CC) $(COCOAFLAGS) ESATMUpdate.o printSelector.o -o printSelector

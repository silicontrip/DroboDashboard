
COCOAFLAGS=-framework Foundation
OBJ=ESATMUpdate.o dash.o

all: dash

ESATMUpdate.o: ESATMUpdate.h ESATMUpdate.m

dash: $(OBJ)
	$(CC) $(COCOAFLAGS) $(OBJ) -o dash

COPTS=-Wall -g -c  -O0 -std=c++0x -Wno-reorder
OBJS=main.o \
	 langlex.o \
	 cSymbol.o \
	 cSymbolTable.o \
	 langparse.o

all: lang

clean:
	rm -f $(OBJS)
	rm -f langlex.c
	rm -f langparse.c
	rm -f langparse.h
	rm -f lang
	rm -f out

.cpp.o:
	g++ $(COPTS) $? -o $@

.c.o:
	g++ $(COPTS) $? -o $@

main.o: main.cpp langparse.c langlex.c 
	g++ $(COPTS) main.cpp -o $@

langlex.c: lang.l langparse.c
	flex -o langlex.c lang.l

langparse.c: lang.y
	bison --defines=langparse.h lang.y -o langparse.c

lang: $(OBJS)
	g++ $(OBJS) -o lang

langlex.o: langlex.c
	g++ $(COPTS) -Wno-sign-compare langlex.c -o $@
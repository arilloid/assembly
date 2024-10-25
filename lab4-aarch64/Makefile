BINARIES=hello
AS=as
LD=ld

all:	${BINARIES}

loop:		loop.s
		${AS}	-g	-o loop.o	loop.s
		${LD}		-o loop		loop.o

clean:	
hello:		hello.s
		${AS}	-g	-o hello.o	hello.s
		${LD}		-o hello	hello.o

clean:	
		rm ${BINARIES} *.o




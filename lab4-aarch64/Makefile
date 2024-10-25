BINARIES=loop1 loop2 loop3
AS=as
LD=ld

all:	${BINARIES}

loop1:		loop1.s
		${AS}	-g	-o loop1.o	loop1.s
		${LD}		-o loop1	loop1.o

loop2:		loop2.s
		${AS}	-g	-o loop2.o	loop2.s
		${LD}		-o loop2	loop2.o	

loop2:		loop3.s
		${AS}	-g	-o loop3.o	loop3.s
		${LD}		-o loop3	loop3.o	

clean:	
		rm ${BINARIES} *.o




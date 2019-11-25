COMPILER= gfortran

EXEC = conversion

SRC = $(wildcard *.f90)

OBJ = $(SRC:.f90=.o)

$(EXEC): $(SRC)
	$(COMPILER) -o $@ $^

read_write.o: read_write.f90
	$(COMPILER) -c $<

convert.o: convert.f90, read_write.o
	$(COMPILER) -c $<

clean:
	rm -rf *.o *.mod *.x $(EXEC)

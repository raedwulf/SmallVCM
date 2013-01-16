# This is under MIT licence
# Also, I am not at all proud of this makefile, feel free to make better

all: 
	g++ -o smallvcm ./src/smallvcm.cxx -O3 -std=c++0x -fopenmp -DHAVE_OPENMP

old_rng:
	g++ -o smallvcm ./src/smallvcm.cxx -O3 -fopenmp -DLEGACY_RNG -DHAVE_OPENMP

clean:
	rm smallvcm

unreport:
	rm *.bmp index.html

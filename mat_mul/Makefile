output: mat_mul.o mat_mul_cuda.o
	nvcc mat_mul.o mat_mul_cuda.o

mat_mul.o: mat_mul.cpp mat_mul.hpp
	g++ -g -c mat_mul.cpp

mat_mul_cuda.o: mat_mul.cu
	nvcc -g -c mat_mul.cu -o mat_mul_cuda.o

clean:
	rm *.o
	rm a.out
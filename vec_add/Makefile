output: vec_add.o vec_add_k.o
	nvcc vec_add.o vec_add_k.o

vec_add.o: vec_add.cpp vec_add_k.cuh
	g++ -g -c vec_add.cpp

vec_add_k.o: vec_add_k.cu
	nvcc -g -c vec_add_k.cu

clean:
	rm *.o
	rm a.out

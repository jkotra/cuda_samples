output: hello_world.o
	nvcc hello_world.o

hello_world.o: hello_world.cu
	nvcc -c hello_world.cu	

clean:
	rm *.o
	rm a.out	
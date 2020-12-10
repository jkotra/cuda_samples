#include <iostream>

__global__ void add_vec_cuda(int *a, int *b, int *c){

    int index = blockDim.x * blockIdx.x + threadIdx.x;
    
    if (index < 100){
        c[index] = a[index] + b[index]; 
    }


}

int* add_vec(int *a, int *b){

    int *d_a, *d_b, *d_c;
    int *c;

    c = (int*) malloc(sizeof(int) * 100);

    int size = 100 * sizeof(int);

    cudaMalloc(&d_a, size);
    cudaMalloc(&d_b, size);
    cudaMalloc(&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);

    add_vec_cuda<<<1, 100>>>(d_a, d_b, d_c);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);


    return c;
}
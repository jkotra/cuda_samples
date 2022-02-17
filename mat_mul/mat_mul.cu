#include <iostream>

__global__ void mul_mat(int *a, int *b, int *c, int n, int m){

    // a = matrix A
    // b = matrix B
    // c = matrix C

    int x = blockDim.x * blockIdx.x + threadIdx.x;
    int y = blockDim.y * blockIdx.y + threadIdx.y;

    int value = 0;

    if (x > n || y > m){
        return;
    }

    for(int i = 0; i < 1024; i++){
        value += a[x * n + i] * b[y + m * i];
    }

    c[x * n + y] = value;

}

void mat_mul_cuda(int *a, int *b, int *c, int n, int m){

    int *d_a, *d_b, *d_c;

    size_t size = m * n * sizeof(int);
    cudaMalloc(&d_a, size);
    cudaMalloc(&d_b, size);
    cudaMalloc(&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);

    int threads = 16;
    int blocks = (n + threads - 1) / threads;
    dim3 BLOCKS (blocks, blocks);
    dim3 THREADS(threads, threads);
    mul_mat<<<BLOCKS, THREADS>>>(d_a, d_b, d_c, n, m);
    cudaDeviceSynchronize();

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

}
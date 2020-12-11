#include<stdio.h>
#include<stdlib.h>

__global__ void from_gpu(void){

    printf("%d, %d\n", blockIdx.x, threadIdx.x);

}

int main(){

    from_gpu<<<10, 10>>>();
    cudaDeviceSynchronize();

    return 0;
}
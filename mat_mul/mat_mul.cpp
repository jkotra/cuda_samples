#include <iostream>
#include <vector>
#include <string>
#include <random>
#include <assert.h>
#include "mat_mul.hpp"

void mat_mul_cpu(int *A, int *B, int *C, int aH)
{

    for (size_t i = 0; i < aH; i++)
    {
        for (size_t j = 0; j < aH; j++)
        {

            int value = 0;

            for (int k = 0; k < aH; k++)
            {
                value += B[k * aH + j] * A[i * aH + k];
            }

            C[i * aH + j] = value;
        }
    }
}

int main()
{

    int r = 1024;
    int c = 1024;
    int elements = r * c;
    int datasize = elements * sizeof(int);

    int *matrixA = (int *)malloc(datasize);
    int *matrixB = (int *)malloc(datasize);
    int *matrixC = (int *)malloc(datasize);     // result
    int *matrixC_CPU = (int *)malloc(datasize); // CPU_result

    // random nyumber
    std::random_device rd;
    std::mt19937 mt(rd());
    std::uniform_int_distribution<int> gen(1, 5);

    // fill data
    for (size_t i = 0; i < elements; i++)
    {
        matrixA[i] = gen(mt);
        matrixB[i] = gen(mt);
    }

    mat_mul_cuda(matrixA, matrixB, matrixC, r, c);
    mat_mul_cpu(matrixA, matrixB, matrixC_CPU, r);

    for (size_t i = 0; i < elements; i++)
    {
        std::cout << matrixC[i] << " ";
    }
    std::cout << std::endl;
    

    for (size_t i = 0; i < r * c; i++)
    {
        assert(matrixC[i] == matrixC_CPU[i]);
    }

    std::cout << "Result Verified!" << std::endl;

    return 0;
}
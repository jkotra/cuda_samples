#include <iostream>
#include <random>
#include <vector>
#include <algorithm>

#include "vec_add_k.cuh"

int main(){

    std::vector<int> a(100), b(100);

    std::generate(a.begin(), a.end(), [&](){ return std::rand() % 10; });
    std::generate(b.begin(), b.end(), [&](){ return std::rand() % 10; });

    int *result = add_vec(a.data(), b.data());

    for (int i = 0; i < 100; i++)
    {
        std::cout << a.at(i) << "+" << b.at(i) << "=" << result[i] << std::endl;
    }

    return 0;
}
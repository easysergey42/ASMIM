#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>


#define M 800
#define N 1000

typedef int mtype;

extern double measure_latency(uint64_t);

extern double  measure_throughput(uint64_t);

int main(){


    mtype* A = (mtype*)malloc(sizeof(mtype) * M*M);
    mtype* B = (mtype*)malloc(sizeof(mtype) * M*M);
    mtype* C = (mtype*)malloc(sizeof(mtype) * M*M);
    for (int i = 0; i < M; ++i){
        for (int j = 0; j < M; ++j){
            A[i*M+j] = i+j % 17;
            B[i*M+j] = i+j % 13;
        }
    }

    for (int i = 0; i < M; ++i){
        for (int j = 0; j < M; ++j){
            for (int k = 0; k < M; ++k){
                C[i * M + j] += A[i*M + k]*B[j*M+k];
            }
        }
    }

    printf("%d\n", C[M*M/2]);

    free(A);
    free(B);
    free(C);

    printf("Latency =  = %lf\n\n", measure_latency(N));
    printf("Throughput = %lf\n", measure_throughput(N));
    return 0;
}
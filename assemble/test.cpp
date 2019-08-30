#include<iostream>
#include<cstring>
#include<cstdio>
#include<algorithm>
#include<ctime>
using namespace std;

int rd(int l,int r){
	return (unsigned)rand()*rand()%(r-l+1)+l ;
}

FILE *input, *output ;
char inputName[]="a.in" , outputName[]="a.out" ;
int n;

int writeInt(int a, FILE* file){
	return fwrite(&a, sizeof(int), 1, file) ;
}

int readInt(int &a, FILE* file){
	return fread(&a, sizeof(int), 1, file) ;
}
int main(int argc, char *argv[]){
	input  = fopen(inputName, "wb") ;
	writeInt(10, input) ;
	n = 10;
	int A[10];
	for(int i = 0; i<n; i++){
        cin >> A[i];
	}
	//int A[10] = {7,8,9,1,2,0,3,5,4,6};
	for(int i=0;i<n;++i){
		writeInt(A[i],input) ;
	}
	fclose(input) ;
	return 0 ;
}

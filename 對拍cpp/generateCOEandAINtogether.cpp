#include<iostream>
#include<cstring>
#include<cstdio>
#include<algorithm>
#include<ctime>
#include<fstream>
using namespace std;

int rd(int l,int r){
	return (unsigned)rand()*rand()%(r-l+1)+l ;
}


char outputName[] = "ain.coe";
char outputName2[] = "a.in";
int n , A[1005] ;

int writeInt(int a, FILE* file){
	return fwrite(&a, sizeof(int), 1, file) ;
}

int readInt(int &a, FILE* file){
	return fread(&a, sizeof(int), 1, file) ;
}

int main(int argc, char *argv[]){
	fstream file;
	FILE *file2 ;
	file2  = fopen(outputName2, "wb");
	file.open(outputName, ios::out);
	int n = 100;
	file << "memory_initialization_radix=10;" << endl;
	file << "memory_initialization_vector=";
	cout << "Enter size: ";
	cin >> n;
	file << n << ", ";
	writeInt(n, file2) ;
		for(int i=1;i<=n;++i){
			A[i]=rd(0, 1000) ;
			file << A[i] << ", ";
			writeInt(A[i], file2) ;
		}
		file << ";" << endl;
		file.close();
	fclose(file2) ;
	return 0 ;
}

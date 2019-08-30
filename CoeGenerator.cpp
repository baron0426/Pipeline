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

FILE *input, *output ;
char outputName[] = "ain.coe";
int n , A[1005] ;

int writeInt(int a, FILE* file){
	return fwrite(&a, sizeof(int), 1, file) ;
}

int readInt(int &a, FILE* file){
	return fread(&a, sizeof(int), 1, file) ;
}

int main(int argc, char *argv[]){
	fstream file;
	file.open(outputName, ios::out);
    int T = 3;
	file << "memory_initialization_radix=10;" << endl;
	file << "memory_initialization_vector=";
	cout << "Enter Test Type: ";
	cin >> T;
	int n ;
		if(T==1) n=rd(1,1000) ;
		else if(T==2) n=rd(1,3) ;
		else if(T==3) n=1000 ;
		else if(T==4) n = 10;
		else if(T==5) n = 100;
		file << n << ", ";
		for(int i=1;i<=n;++i){
			A[i]=rd(0, 1000) ;
			file << A[i] << ", ";
		}
		file << ";" << endl;
		file.close();
	return 0 ;
}

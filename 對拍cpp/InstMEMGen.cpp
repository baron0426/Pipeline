#include<iostream>
#include<string>
#include<cstring>
#include<cstdio>
#include<algorithm>
#include<ctime>
#include<fstream>
using namespace std;
char inName[] = "msort_forhardCPU.machine";
char outputName[] = "msort_Inst_Mem.txt";
//8'd0:    Instruction <= 32'h08000003;
int main(int argc, char *argv[]){
	fstream inst_in;
	inst_in.open(inName, ios::in);
	fstream inst_out;
	inst_out.open(outputName, ios::out);
	for(int i = 0; !inst_in.eof(); i++){
		string inst_tmp;
		getline(inst_in, inst_tmp);
		string out_tmp ="8\'d";
		out_tmp += to_string(i);
		out_tmp +=":Instruction <= 32'h";
		out_tmp += inst_tmp;
		out_tmp +=";\n";
		inst_out << out_tmp;
	}
	inst_in.close();
	inst_out.close();
	return 0 ;
}

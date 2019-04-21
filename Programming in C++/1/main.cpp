#include <iostream>
#include <cmath>
#include <string>
#include <vector>
#include <typeinfo>
#include <algorithm>

using namespace std;

bool isprime(int d){
    int i=2;
    if(d==2){
        return true;
    }
    while(i<=ceil(sqrt(d))){
            if(d%i==0){
                return false;
            }else{
            i++;
            }
    return true;
}}

int64_t factor(int64_t d) {
	for (int64_t i = 2; i < d; i++) {
		if (!isprime(i)) {
			continue;
		}
		if (d % i == 0) {
			return i;
		}
	}
	return d;
}

vector<int64_t> factors_tab(int64_t d) {
	vector<int64_t> tab;
	if(d==1){
        tab.push_back(1);
	}
	if(d==0){
        tab.push_back(0);
	}
    if(d<0){
        tab.push_back(-1);
        d=d*(-1);
    }
	while (d > 1) {
		int64_t c = factor(d);
		d /= c;
		tab.push_back(c);
	}
	return tab;
}

void print( int x )
{
    cout << x;
}


int main(int argc, char *argv[]) {

	if(argc==1){
        cerr << "nie podano zadnej liczby calkowitej!" << endl;
	}
    string integer;
	vector<string> integers;
	for (int i = 1; i < argc; i++) {
		string integer(argv[i]);
		integers.push_back(integer);
	}

	string str;

	vector<string> input;
	for (int i = 1; i < argc; i++) {
		string str(argv[i]);
		input.push_back(str);
	}

	for (int i = 0; i < argc - 1; i++) {
		int64_t l = stoll(input[i]);
		vector<int64_t> tab_2 = factors_tab(l);
		for (int64_t el : tab_2) {
            int pos = std::find(tab_2.begin(), tab_2.end(), el) - tab_2.begin();
            if(pos==0){
                cout << l << " = ";
            }
            if(pos==tab_2.size()-1){
                cout << el;
            }else{
                cout << el << " * ";
            }
		}
		cout << "\n";
	}
}

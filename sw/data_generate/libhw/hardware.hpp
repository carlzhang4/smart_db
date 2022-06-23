#ifndef _HARDWARE_HPP_
#define _HARDWARE_HPP_
#include <string>
#include <sstream>
#include<iostream>
#include <vector>
#include <assert.h>
#include <climits>
using namespace std;

vector<bool> ul2bin(unsigned long value,int width);

string bin2hex_(string s);

string bin2hex(const string &s);

unsigned long get_musk(int width);

int round_up(int value,int m);

class Base{
	public:
	vector<Base*>bits;
	void operator=(const Base &t );

	template<typename T>
	T* append(T*t){
		bits.push_back(t);
		return t;
	};

	template<typename T>
	T* append(T* t, int num){
		for(int i=num-1;i>=0;i--){ //note that this order must be reversed because of chisel vec 
			bits.push_back(t+i);
		}
		return t;
	};

	virtual int getWidth();
	virtual string toString();
	virtual string toHex();
	virtual string toTxt();
	virtual string toTxt(int align);
	virtual void setValue(unsigned long *l);
	virtual int setValue(int off,unsigned long *l);
	virtual string catBin();
	virtual string catHex();
	virtual string catWidth();
};

class Reg:public Base{

	public:
		unsigned long value;
		int width;
		vector<bool> bin;

		Reg();

		Reg(const Reg& other);

		Reg(unsigned long value,int width);
		void init(unsigned long value,int width);
		void operator=(const Reg &t );

		void operator=(unsigned long value);

		void operator=(int value);

		void setValue(unsigned long value);

		int setValue(int off, unsigned long *l);

		string toString();
		string catBin();
		string catHex();
		string catWidth();

		string hex();
		
		unsigned long dec();

		int getWidth();
};
#endif
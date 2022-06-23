#include "hardware.hpp"

vector<bool> ul2bin(unsigned long value,int width){
	unsigned long mask = 1;
	vector<bool> res;

	for(int i=0;i<width;i++){
		if(mask & value){
			res.push_back(1);
		}else{
			res.push_back(0);
		}
		mask<<=1;
	}
	return res;
}

string bin2hex_(string s){
	int v = 0;
	for(int i=0;i<s.length();i++){
		v=(v<<1)+(s[i]=='1');
	}
	stringstream ss;
	ss<<std::hex<<v;
	return ss.str();
}

string bin2hex(const string &s){
	string res;
	int len = s.length();
	int start = len%4;
	if(start != 0){
		res += bin2hex_(s.substr(0,start));
	}
	for(int i=start;i<len;i+=4){
		res += bin2hex_(s.substr(i,4));
	}
	return res;
}

unsigned long get_musk(int width){
	assert(width>0);
	assert(width<=64);
	if(width == 64){
		return ULONG_MAX;
	}else{
		return (1ul<<width)-1;
	}
}

int round_up(int value,int m){
	assert(m);
	return ((value+m-1)/m)*m;
}



void Base::operator=(const Base &t ){ }//todo


int Base::getWidth(){
	int width = 0;
	for(int i=0;i<bits.size();i++){
		width += (bits[i]->getWidth());
	}
	return width;
};
string Base::toString(){
	string res;
	for(int i=0;i<bits.size();i++){
		res += (bits[i]->toString());
	}
	return res;
};
string Base::toHex(){
	return bin2hex(toString());
}
string Base::toTxt(){
	string s = toHex();
	return s+'\n';
}
string Base::toTxt(int align){
	assert(align%4==0);
	align/=4;//bit to 4bits
	string s = toHex();

	int pad_len = round_up(s.length(),align)-s.length();
	s.insert(s.begin(), pad_len, '0');

	
	string res;
	for(int i=s.length()-align;i>=0;i-=align){
		res+=s.substr(i,align);
		res+='\n';
	}
	return res;
}
void Base::setValue(unsigned long *l){
	int offset = 0;
	for(int i=0;i<bits.size();i++){
		offset = bits[i]->setValue(offset,l);
	}
}
int Base::setValue(int off,unsigned long *l){
	int offset = off;
	for(int i=0;i<bits.size();i++){
		offset = bits[i]->setValue(offset,l);
	}
	return offset;
}
string Base::catBin(){
	string res="{";
	for(int i=0;i<bits.size();i++){
		res += (bits[i]->catBin());
	}
	int len = res.length();
	return res.substr(0,len-2)+"} ";
}
string Base::catHex(){
	string res="{";
	for(int i=0;i<bits.size();i++){
		res += (bits[i]->catHex());
	}
	int len = res.length();
	return res.substr(0,len-2)+"} ";
}
string Base::catWidth(){
	string res="{";
	for(int i=0;i<bits.size();i++){
		res += (bits[i]->catWidth());
	}
	int len = res.length();
	return res.substr(0,len-2)+"} ";
}




Reg::Reg(){};

Reg::Reg(const Reg& other){
	value = other.value;
	width = other.width;
	bin = other.bin;
};

Reg::Reg(unsigned long value,int width){
	assert(width<=64);
	assert(width>0);
	this->width = width;
	this->value = value&get_musk(width);
	this->bin = ul2bin(this->value,width);
};
void Reg::init(unsigned long value,int width){
	assert(width<=64);
	assert(width>0);
	this->width = width;
	this->value = value&get_musk(width);
	this->bin = ul2bin(this->value,width);
};

void Reg::operator=(const Reg &t ){ 
	this->width = t.width;
	this->value = t.value;
	this->bin = ul2bin(t.value,t.width);
}

void Reg::operator=(unsigned long value){ 
	this->setValue(value);
}

void Reg::operator=(int value){ 
	this->setValue((unsigned long)value);
}

void Reg::setValue(unsigned long value){
	this->value = value&get_musk(this->width);
	assert(value == this->value);//out of range
	this->bin = ul2bin(value,this->width);
}

int Reg::setValue(int off, unsigned long *l){
	this->setValue(l[off]);
	return off+1;
}

string Reg::toString(){
	stringstream s;
	for(int i=width-1;i>=0;i--){
		s<<(bin[i]?'1':'0');
	}
	return s.str();
}
string Reg::catBin(){
	return toString()+", ";
}
string Reg::catHex(){
	return hex()+", ";
}
string Reg::catWidth(){
	return to_string(width)+", ";
}

string Reg::hex(){
	stringstream s;
	s<<std::hex<<value;
	return s.str();
}

unsigned long Reg::dec(){
	return value;
}	

int Reg::getWidth(){
	return width;
}
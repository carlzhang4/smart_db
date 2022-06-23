#include "common.hpp"

string trim(string& s){
	s.erase(0, s.find_first_not_of(" "));
	s.erase(s.find_last_not_of(" ")+1);
	return s;
}

vector<string> split(const string& input, const string& regex) {
    // passing -1 as the submatch index parameter performs splitting
    std::regex re(regex);
    std::sregex_token_iterator
        first{input.begin(), input.end(), re, -1},
        last;
    return {first, last};
}

map<string,ulong> parse_csv(string& input){
	map<string,ulong> dict;
	auto vec = split(input, ",");
	for(auto kv : vec){
		auto k_v = split(kv,":");
		string k = trim(k_v[0]);
		string v = trim(k_v[1]);
		dict.insert(pair<string,ulong>(k,stoul(v)));
	}

	return dict;
}
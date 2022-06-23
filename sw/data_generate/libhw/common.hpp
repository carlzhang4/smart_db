#ifndef _CJ_COMMON_HPP_
#define _CJ_COMMON_HPP_

#include <string>
#include <sstream>
#include <vector>
#include <assert.h>
#include <regex>
#include <map>
using namespace std;

string trim(string& s);
vector<string> split(const string& input, const string& regex);
map<string,ulong> parse_csv(string& input);
#endif
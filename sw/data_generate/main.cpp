#include<iostream>
#include <fstream>
#include"bench.hpp"
using namespace std;



int main(){
	int num_tables			= 4;
	int num_buckets 		= 10;
	int slots_per_bucket	= 6;
	// bench_simple(num_tables,num_buckets,slots_per_bucket);
	bench_dual_mem(num_tables,num_buckets,slots_per_bucket);
	// bench_block_handler(num_tables,num_buckets,slots_per_bucket);
	return 0;
}
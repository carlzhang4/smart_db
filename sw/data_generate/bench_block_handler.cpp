#include"bench.hpp"
using namespace std;


vector <Req> init_req(int num_tables, int num_buckets, int slots_per_bucket){
	int table_idx_bits		= log2(num_tables);
	int slots_size_bits		= ceil(log2(slots_per_bucket));
	ofstream outfile;
	outfile.open("../data/block_handler/reqs.txt",ios::out|ios::trunc);

	vector <Req> reqs;

	for(int i=0;i<100;i++){
		Req req(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req.setValue(0, i%10, 0);
		reqs.push_back(req);	
	}

	for(auto req : reqs){
		outfile<<req.toTxt();
	}
	return reqs;
}

void bench_block_handler(int num_tables, int num_buckets, int slots_per_bucket){
	auto reqs = init_req(num_tables, num_buckets, slots_per_bucket);
	for(auto req : reqs){
		cout<<req.toPrintable()<<endl;
	}
}
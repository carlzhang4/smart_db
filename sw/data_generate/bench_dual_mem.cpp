#include"bench.hpp"
using namespace std;

// int Req::cur_id = 0;

vector<vector <Req>> init_req_dual_mem(int num_tables, int num_buckets, int slots_per_bucket, vector<string>& msgs){
	int table_idx_bits		= log2(num_tables);
	int slots_size_bits		= ceil(log2(slots_per_bucket));
	ofstream outfile;
	outfile.open("../data/reqs.txt",ios::out|ios::trunc);
	vector<vector <Req>> req_group;

	{
		vector<Req> reqs;
		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req3(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(0, 0, 0x0);
		req1.setValue(0, 0, 0x100000000);
		req2.setValue(0, 0, 0x200000000);
		req3.setValue(0, 0, 0x300000000);
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);
		reqs.push_back(req3);
		req_group.push_back(reqs);
		msgs.push_back("Lock S d0/d1/d2, Lock S d3 Error");
	}

	{
		vector<Req> reqs;
		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req3(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(0, 0, 0x300000001);
		req1.setValue(0, 0, 0x100000001);
		req2.setValue(0, 0, 0x200000001);
		req3.setValue(0, 0, 0x1);
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);
		reqs.push_back(req3);
		*(req0.lock) = 1;
		*(req1.lock) = 1;
		*(req2.lock) = 1;
		*(req3.lock) = 1;
		req_group.push_back(reqs);
		msgs.push_back("Lock X d3 Error, Lock X d0/d1/d2");
	}

	{
		vector<Req> reqs;
		for(int i=0;i<256;i++){
			Req req(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
			req.setValue(0, 1, 0x200000002);
			reqs.push_back(req);	
		}
		req_group.push_back(reqs);
		msgs.push_back("Lock 256 S d2 Fail");
	}
	
	for(auto reqs : req_group){
		for(auto req : reqs){
			outfile<<req.toTxt();
		}
	}
	return req_group;
}
vector<vector<Bucket>> init_hbm_dual_mem(int num_tables, int num_buckets, int slots_per_bucket){
	int HBM_WORD = 256;
	vector<vector<Bucket>> tables;
	ofstream outfile;

	for(int i=0;i<num_tables;i++){
		vector<Bucket> cur_table;
		
		outfile.open("../data/hbm"+to_string(i)+".txt",ios::out|ios::trunc);
		for(int j=0;j<num_buckets;j++){
			Bucket b(slots_per_bucket);
			unsigned long idx = i*num_buckets*slots_per_bucket + slots_per_bucket*j;
			for(int k=0;k<slots_per_bucket;k++){
				*(b.slots[k].host_addr) 			= idx+k;
				*(b.slots[k].key) 					= idx+k;
				*(b.slots[k].valid) 				= 1;
				b.exclusive_state[k]				= 0;
				b.shared_count[k]					= 0;
			}
			*(b.has_next)		= 1;
			*(b.next_idx) 		= num_buckets + j;
			*(b.tb_idx) 		= i;
			*(b.idx) 			= j;
			cur_table.push_back(b);
			outfile<<b.toTxt(HBM_WORD);
		}
		outfile.close();

		outfile.open("../data/oc_mem"+to_string(i)+".txt",ios::out|ios::trunc);
		for(int j=0;j<num_buckets;j++){
			Bucket b(slots_per_bucket);
			unsigned long idx = 0x100000000 + i*num_buckets*slots_per_bucket + slots_per_bucket*j;
			for(int k=0;k<slots_per_bucket;k++){
				*(b.slots[k].host_addr) 			= idx+k;
				*(b.slots[k].key) 					= idx+k;
				*(b.slots[k].valid) 				= 1;
				b.exclusive_state[k]				= 0;
				b.shared_count[k]					= 0;
			}
			*(b.has_next)		= 1;
			*(b.next_idx) 		= j+num_buckets*2;
			*(b.tb_idx) 		= i;
			*(b.idx) 			= j+num_buckets;
			cur_table.push_back(b);
			outfile<<b.toTxt();
		}

		for(int j=0;j<num_buckets;j++){
			Bucket b(slots_per_bucket);
			unsigned long idx = 0x200000000 + i*num_buckets*slots_per_bucket + slots_per_bucket*j;
			for(int k=0;k<slots_per_bucket;k++){
				*(b.slots[k].host_addr) 			= idx+k;
				*(b.slots[k].key) 					= idx+k;
				*(b.slots[k].valid) 				= 1;
				b.exclusive_state[k]				= 0;
				b.shared_count[k]					= 0;
			}
			*(b.has_next)		= 0;
			*(b.next_idx) 		= 0;
			*(b.tb_idx) 		= i;
			*(b.idx) 			= j+2*num_buckets;
			cur_table.push_back(b);
			outfile<<b.toTxt();
		}

		tables.push_back(cur_table);
		outfile.close();
	}
	return tables;
}


void bench_dual_mem(int num_tables, int num_buckets, int slots_per_bucket){
	auto tables = init_hbm_dual_mem(num_tables, num_buckets, slots_per_bucket);
	store_table(tables, "dualmem");
	vector<string> msgs;
	auto req_group = init_req_dual_mem(num_tables, num_buckets, slots_per_bucket, msgs);
	
	vector<Req> reqs;
	for(int i=0;i<req_group.size();i++){
		for(int j=0;j<req_group[i].size();j++){
			reqs.push_back(req_group[i][j]);
		}
	}
	vector<vector<int>> input_seqs;
	vector<Result>results_rtl;
	vector<Result>results_cpp;
	results_rtl.resize(reqs.size());
	results_cpp.resize(reqs.size());
}
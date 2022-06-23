

#include"bench.hpp"
#include <cj/common.hpp>


using namespace std;

int Req::cur_id = 0;

vector<vector <Req>> init_req(int num_tables, int num_buckets, int slots_per_bucket, vector<string>& msgs){
	int table_idx_bits		= log2(num_tables);
	int slots_size_bits		= ceil(log2(slots_per_bucket));
	ofstream outfile;
	outfile.open("../data/reqs.txt",ios::out|ios::trunc);
	vector<vector <Req>> req_group;
	{
		vector<Req> reqs;
		for(int i=0;i<5;i++){
			Req req(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
			req.setValue(1, 0, i);
			reqs.push_back(req);	
		}
		req_group.push_back(reqs);
		msgs.push_back("Lock S Error");
	}
	

	{
		vector<Req> reqs;

		for(int i=0;i<5;i++){
			Req req(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
			req.setValue(1, 0, i);
			*(req.lock) = 1;
			reqs.push_back(req);
		}

		req_group.push_back(reqs);
		msgs.push_back("Lock X Error");
	}

	{
		vector<Req> reqs;

		for(int i=0;i<256;i++){
			Req req(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
			req.setValue(0, 0, 0);
			reqs.push_back(req);
		}

		req_group.push_back(reqs);
		msgs.push_back("Lock 256 S Fail");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(1,0,0x3c);
		req1.setValue(1,0,0x3c);
		*(req1.lock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);

		req_group.push_back(reqs);
		msgs.push_back("Lock S, Lock X Fail");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(1,0,0x3d);
		req1.setValue(1,0,0x3d);
		req2.setValue(1,0,0x3d);
		*(req2.lock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);

		req_group.push_back(reqs);
		msgs.push_back("Lock S, Lock S, Lock X Fail");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(1,0,0x3e);
		req1.setValue(1,0,0x3e);
		*(req0.lock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);

		req_group.push_back(reqs);
		msgs.push_back("Lock X, Lock S Fail");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(1,0,0x3f);
		req1.setValue(1,0,0x3f);
		*(req0.lock) = 1;
		*(req1.lock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);

		req_group.push_back(reqs);
		msgs.push_back("Lock X, Lock X Fail");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(2,0,0x78);
		req1.setValue(2,0,0x78);
		req2.setValue(2,0,0x78);
		*(req1.is_unlock) = 1;
		*(req2.is_unlock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);

		req_group.push_back(reqs);
		msgs.push_back("Lock S, Unlock S, Unlock S Error");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(2,0,0x79);
		req1.setValue(2,0,0x79);
		req2.setValue(2,0,0x79);
		*(req1.is_unlock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);

		req_group.push_back(reqs);
		msgs.push_back("Lock S, Unlock S, lock S");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(2,0,0x7a);
		req1.setValue(2,0,0x7a);
		req2.setValue(2,0,0x7a);
		*(req1.is_unlock) = 1;
		*(req2.lock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);

		req_group.push_back(reqs);
		msgs.push_back("Lock S, Unlock S, Lock X");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(2,0,0x7b);
		req1.setValue(2,0,0x7b);
		*(req0.lock) = 1;
		*(req1.is_unlock) = 1;
		reqs.push_back(req0);
		reqs.push_back(req1);

		req_group.push_back(reqs);
		msgs.push_back("Lock X, Unlock S Error");
	}

	{
		vector<Req> reqs;

		Req req0(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req0.setValue(2,0,0x7c);
		req1.setValue(2,0,0x7c);
		req2.setValue(2,0,0x7c);
		*(req0.lock) = 1;
		*(req1.lock) = 1;
		*(req1.is_unlock) = 1;
		*(req1.slot_idx)  = 4;
		reqs.push_back(req0);
		reqs.push_back(req1);
		reqs.push_back(req2);

		req_group.push_back(reqs);
		msgs.push_back("Lock X, Unlock X, Lock S");
	}

	{
		vector<Req> reqs;

		for(int i=0;i<256;i++){
			Req req(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
			req.setValue(2, 0, 0x7d);
			reqs.push_back(req);
		}
		Req req1(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		Req req2(KEY_BITS, ADDR_BITS, LOCK_BITS, table_idx_bits, slots_size_bits);
		req1.setValue(2, 0, 0x7d);
		req2.setValue(2, 0, 0x7d);
		*(req1.is_unlock) = 1;
		reqs.push_back(req1);
		reqs.push_back(req2);

		req_group.push_back(reqs);
		msgs.push_back("Lock 256 S Fail, Unlock S, Lock S");
	}


	
	for(auto reqs : req_group){
		for(auto req : reqs){
			outfile<<req.toTxt();
		}
	}
	return req_group;
}
vector<vector<Bucket>> init_hbm(int num_tables, int num_buckets, int slots_per_bucket){
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
			*(b.has_next)		= 0;
			*(b.next_idx) 		= 0;
			*(b.tb_idx) 		= i;
			*(b.idx) 			= j;
			cur_table.push_back(b);
			outfile<<b.toTxt(HBM_WORD);
		}
		tables.push_back(cur_table);
		outfile.close();
	}
	return tables;
}


void bench_simple(int num_tables, int num_buckets, int slots_per_bucket){
	auto tables = init_hbm(num_tables, num_buckets, slots_per_bucket);
	store_table(tables, "simple");
	vector<string> msgs;
	auto req_group = init_req(num_tables, num_buckets, slots_per_bucket, msgs);

	// return;

	// for(int i=0;i<req_group.size();i++){
	// 	cout<<msgs[i]<<":"<<endl;
	// 	for(int j=0;j<req_group[i].size();j++){
	// 		auto req = req_group[i][j];
	// 		auto res = process_request(req, tables, 0);
	// 		cout<<res.toPrintable()<<endl;
	// 	}
	// 	cout<<endl;
	// }

	vector<Req> reqs;
	for(int i=0;i<req_group.size();i++){
		for(int j=0;j<req_group[i].size();j++){
			reqs.push_back(req_group[i][j]);
		}
	}

	vector<vector<int>> rtl_seqs;
	vector<Result>results_rtl;
	vector<Result>results_cpp;
	results_rtl.resize(reqs.size());
	results_cpp.resize(reqs.size());

	load_sim_res(num_tables, rtl_seqs, results_rtl);

	execute_cpp_sim(reqs, rtl_seqs, tables, results_cpp);//note that reqs' contents will change and will contain execution result

	print_by_table(rtl_seqs, reqs, results_cpp, results_rtl);
	// print_by_group(req_group, reqs, results_cpp, results_rtl, msgs);

	verify_results(results_cpp, results_rtl);	
}
#include"bench.hpp"
using namespace std;

char * time_string() {
  struct timespec ts;
  clock_gettime( CLOCK_REALTIME, &ts);
  struct tm * timeinfo = localtime(&ts.tv_sec);
  static char timeStr[20];
  sprintf(timeStr, "%.2d:%.2d:%.2d.%.3ld", timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec, ts.tv_nsec / 1000000);
  return timeStr;
}

void store_table(vector<vector<Bucket>> tables, string file_name){
	ofstream outfile;
	outfile.open("../data/"+file_name+".table",ios::out|ios::trunc);
	for(int i=0;i<tables.size();i++){
		outfile<<"Tables:"<<i<<endl;
		for(int j=0;j<tables[i].size();j++){
			outfile<<tables[i][j].toPrintable();
		}
	}
}

Req process_request(Req &req, vector<vector<Bucket>>& memory, int depth){
	ulong req_key		= req.key->dec();
	ulong tb_idx		= req.tb_idx->dec();
	ulong bucket_idx	= req.bucket_idx->dec();
	ulong is_unlock		= req.is_unlock->dec();
	ulong req_lock_type	= req.lock->dec();


	assert(tb_idx<memory.size());
	assert(bucket_idx<memory[tb_idx].size());
	auto bucket	= memory[tb_idx][bucket_idx];
	int has_next = bucket.has_next->dec();


	for(int i=0;i<bucket.num_slots;i++){
		auto slot 		= bucket.slots[i];
		int valid 		= slot.valid->dec();
		ulong key 		= slot.key->dec();
		ulong host_addr = slot.host_addr->dec();
		if(req_key == key && valid){//hit
			*(req.hit) = 1;
			*(req.slot_idx) = i;
			int shared_count 	= bucket.shared_count[i].dec();
			int exclusive_state = bucket.exclusive_state[i].dec();
			if(is_unlock){
				if(req_lock_type == 1){//exclusive unlock always success
					*(req.success) = 1;
					bucket.exclusive_state[i] = 0;
				}else{
					if(shared_count > 0){
						*(req.success) = 1;
						*(req.shared_count) = shared_count;
						bucket.shared_count[i] = shared_count-1;
					}
				}
			}else{
				*(req.shared_count) = shared_count;
				if(req_lock_type == 0){
					if(exclusive_state == 0){//get s success
						if(shared_count < 255){
							bucket.shared_count[i] = shared_count+1;
							*(req.success) = 1;
						}
					}
				}else{//exclusive
					if(exclusive_state == 0 && shared_count == 0){//get x success
						bucket.exclusive_state[i] = 1;
						*(req.success) = 1;
					}
				}
			}
			break;
		}
	}
	if(req.hit->dec() == 1){
		return req;
	}else{
		if(has_next == 0){//error
			return req;
		}else{
			return process_request(req, memory, depth+1);
		}
	}
}

void load_sim_res(int num_tables, vector<vector<int>> &seq, vector<Result> &results){
	seq.resize(num_tables);
	ifstream infile;
	string line;
	infile.open("../data/output");
	int count_seq = 0;
	int count_res = 0;
	while(getline(infile, line)){
		auto dict = parse_csv(line);

		assert(dict.count("id") == 1);
		assert(dict.count("type") == 1);
		assert(dict.count("result") == 1);
		assert(dict.count("tb_idx") == 1);
		assert(dict.count("bucket_idx") == 1);
		assert(dict.count("key") == 1);
		assert(dict.count("slot_idx") == 1);
		assert(dict.count("shared_count") == 1);

		if(dict.count("seq")==1){
			int id		= dict["id"];
			int tb_idx	= dict["tb_idx"];
			seq[tb_idx].push_back(id);
			count_seq+=1;
		}else{
			int id				= dict["id"];
			int type			= dict["type"];
			int result			= dict["result"];
			int tb_idx			= dict["tb_idx"];
			ulong bucket_idx	= dict["bucket_idx"];
			ulong key			= dict["key"];
			int slot_idx		= dict["slot_idx"];
			int shared_count	= dict["shared_count"];
			
			Result res;
			res.id				= id;
			res.type			= type;
			res.result			= result;
			res.tb_idx			= tb_idx;
			res.bucket_idx		= bucket_idx;
			res.key				= key;
			res.slot_idx		= slot_idx;
			res.shared_count	= shared_count;

			results[id] = res;
			count_res+=1;
		}
	}
	LOG_I("Load [%d] rtl seqs, [%d] rtl results",count_seq,count_res);
	infile.close();
}

void execute_cpp_sim(vector<Req> &reqs, vector<vector<int>> &input_seqs, vector<std::vector<Bucket>> &tables, vector<Result> &results_cpp){
	for(int tb_idx=0;tb_idx<input_seqs.size();tb_idx++){
		auto cur_seq = input_seqs[tb_idx];
		for(int i=0;i<cur_seq.size();i++){
			auto id = cur_seq[i];
			auto res = process_request(reqs[id], tables, 0);
			results_cpp[id] = res.getResult();
		}
	}
}

void verify_results(vector<Result> &results_cpp, vector<Result> &results_rtl){
	for(int i=0;i<results_cpp.size();i++){
		int flag = 0;
		if(results_rtl[i].id != results_cpp[i].id){
			flag = 1;
		}
		if(results_rtl[i].type != results_cpp[i].type){
			flag = 1;
		}
		if(results_rtl[i].result != results_cpp[i].result){
			flag = 1;
		}
		if(results_rtl[i].tb_idx != results_cpp[i].tb_idx){
			flag = 1;
		}
		if(results_rtl[i].bucket_idx != results_cpp[i].bucket_idx){
			flag = 1;
		}
		if(results_rtl[i].key != results_cpp[i].key){
			flag = 1;
		}
		if(results_rtl[i].slot_idx != results_cpp[i].slot_idx){
			flag = 1;
		}
		if(results_rtl[i].shared_count != results_cpp[i].shared_count){
			flag = 1;
		}
		if(flag == 1){
			cout<<"Verify failed at "<<i<<endl;
			return;
		}
	}
	cout<<"Verify successed!"<<endl;
}

void print_by_table(vector<vector<int>> &input_seqs, vector<Req> reqs, vector<Result> &results_cpp, vector<Result> &results_rtl){
	for(int i=0;i<input_seqs.size();i++){
		cout<<"Table:"<<i<<endl;
		auto cur_seq = input_seqs[i]; 
		for(int j=0;j<cur_seq.size();j++){
			int id = cur_seq[j];
			// cout<<results_cpp[id].result<<" "<<results_rtl[id].result<<" ";
			cout<<reqs[id].toPrintable()<<endl;
		}
	}
}

void print_by_group(vector<vector <Req>> &req_group, vector<Req> &reqs, vector<Result> &results_cpp, vector<Result> &results_rtl, vector<string>msgs){
	int count=0;
	for(int i=0;i<req_group.size();i++){
		cout<<msgs[i]<<":"<<endl;
		for(int j=0;j<req_group[i].size();j++){
			cout<<reqs[count++].toPrintable()<<endl;
		}
		cout<<endl;
	}
}
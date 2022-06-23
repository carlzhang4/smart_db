#ifndef _BENCH_HPP_
#define _BENCH_HPP_

#include <vector>
#include<iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <sstream>
#include <cmath>
#include <cj/hardware.hpp>
#include <cj/common.hpp>
#include <ctype.h>

#define KEY_BITS 60
#define ADDR_BITS 33
#define LOCK_BITS 2
#define ONCHIP_WIDTH 33

#define DEBUG
#define INFO

#define __FILENAME__ (strrchr(__FILE__, '/') + 1)

char * time_string();

#ifdef DEBUG
#define LOG_D(format, ...) \
{char buf[60];\
snprintf(buf,60,"[DEBUG][%s][%s:%d][%s]",time_string(), __FILENAME__,  __LINE__, __FUNCTION__ );\
printf("%-60s" format "\n",buf, ##__VA_ARGS__);}
#else
#define LOG_D(format, ...)
#endif

#ifdef INFO
#define LOG_I(format, ...)  \
{char buf[60];\
snprintf(buf,60,"[INFO][%s][%s:%d][%s]",time_string(), __FILENAME__,  __LINE__, __FUNCTION__ );\
printf("%-60s" format "\n",buf, ##__VA_ARGS__);}
#else
#define LOG_I(format, ...)
#endif

#define LOG_E(format, ...) fprintf(stderr, "[ERROR][%s][%s:%d][%s]: " format "\n",time_string(), __FILENAME__, __LINE__, __FUNCTION__, ##__VA_ARGS__);\
exit(1);

class Slot:public Base{
	public:
		Reg* host_addr;
		Reg* key;
		Reg* valid;

		Slot(){
			host_addr 		= append(new Reg(0,64));
			key 			= append(new Reg(0,KEY_BITS));
			valid 			= append(new Reg(1,1));
		}
};

class Bucket:public Base{
	public:
		Slot* slots;
		Reg* has_next;
		Reg* next_idx;
		Reg* tb_idx;
		Reg* idx;
		Reg* exclusive_state;
		Reg* shared_count;
		int num_slots;

		Bucket(int n){
			slots			= append(new Slot[n](),n);
			has_next 		= append(new Reg(0,1));
			next_idx		= append(new Reg(0,ONCHIP_WIDTH));
			tb_idx			= append(new Reg(0,5));
			idx				= append(new Reg(0,32));
			exclusive_state	= append(new Reg[n](),n);
			shared_count	= append(new Reg[n](),n);

			num_slots = n;

			for(int i=0;i<n;i++){
				exclusive_state[i].init(0,8);
				shared_count[i].init(0,8);
			}
		}

		string toPrintable(int detailed=0){
			int tb_idx_		= tb_idx->dec();
			int idx_	 	= idx->dec();
			int has_next_	= has_next->dec();
			int next_idx_	= next_idx->dec();

			stringstream s;
			s<<setw(4)<<idx_<<" ";

			for(int i=0;i<num_slots;i++){
				auto slot 			= slots[i];
				ulong key_ 			= slot.key->dec();
				ulong host_addr_ 	= slot.host_addr->dec();
				int valid_			= slot.valid->dec();

				s<<hex;
				s<<"[";

				if(valid_){
					s	<<setw(16)<<key_;
					if(detailed){
						s	<<","<<setw(16)<<host_addr_;
					}
				}else{
					s	<<setw(16 + 17*detailed)<<"";
				}
				
				s<<"] ";
			}
			if(has_next_ == 0){
				s<<" NULL"<<endl;
			}else{
				s<<setw(4)<<dec<<next_idx_<<endl;
			}
			return s.str();
		}
};

class Result{
	public:
		int id;
		int type;
		int result;
		int tb_idx;
		ulong bucket_idx;
		ulong key;
		int slot_idx;
		int shared_count;
		Result(){};
};

class Req:public Base{
	public:
		Reg* key;
		Reg* tb_idx;
		Reg* bucket_idx;
		Reg* bucket_idx_raw;
		Reg* lock;
		Reg* is_unlock;
		
		Reg* id;
		Reg* len;
		Reg* last;

		Reg* slot_idx;
		Reg* shared_count;
		Reg* host_addr;
		Reg* success;
		Reg* hit;
		

		int key_bits;
		int addr_bits;
		int lock_bits;
		int table_idx_bits;
		static int cur_id;
	Req(int key_bits, int addr_bits, int lock_bits, int table_idx_bits, int slots_size_bits){
		
		key				= append(new Reg(0,key_bits));
		tb_idx			= append(new Reg(0,table_idx_bits));
		bucket_idx_raw	= append(new Reg(0,addr_bits));
		bucket_idx		= append(new Reg(0,addr_bits));
		lock			= append(new Reg(0,lock_bits));
		is_unlock		= append(new Reg(0,1));
		id				= append(new Reg(0,32));
		len				= append(new Reg(3,4));
		last			= append(new Reg(0,1));

		
		slot_idx		= append(new Reg(0,slots_size_bits));
		shared_count	= append(new Reg(0,8));
		host_addr		= append(new Reg(0,64));
		success			= append(new Reg(0,1));
		hit				= append(new Reg(0,1));
	}
	Result getResult(){
		
		Result res;

		if(is_unlock->dec() == 0 && lock->dec() == 0){
			res.type	= 0;
		}else if(is_unlock->dec() == 0 && lock->dec() == 1){
			res.type	= 1;
		}else if(is_unlock->dec() == 1 && lock->dec() == 0){
			res.type	= 2;
		}else if(is_unlock->dec() == 1 && lock->dec() == 1){
			res.type	= 3;
		}

		if(success->dec() == 1){
			res.result	= 0;
		}else if(hit->dec()==0 || is_unlock->dec() ==1){//error
			res.result	= 2;
		}else{
			res.result	= 1;
		}

		res.id				= id->dec();
		res.tb_idx			= tb_idx->dec();
		res.bucket_idx		= bucket_idx->dec();
		res.key				= key->dec();
		res.slot_idx		= slot_idx->dec();
		res.shared_count	= shared_count->dec();

		return res;
	}
	void setValue(int tb_idx_, int bucket_idx_, ulong key_){
		*key		 	= key_;
		*tb_idx		 	= tb_idx_;
		*bucket_idx	 	= bucket_idx_;
		*bucket_idx_raw	= bucket_idx_;
		*id		 		= cur_id++;
	}

	string toPrintable(){
		int key_ 			= key->dec();
		int tb_idx_ 		= tb_idx->dec();
		int bucket_idx_ 	= bucket_idx->dec();
		int lock_ 			= lock->dec();
		int is_unlock_ 		= is_unlock->dec();
		int id_ 			= id->dec();
		int len_ 			= len->dec();
		int last_			= last->dec();
		int slot_idx_		= slot_idx->dec();
		int shared_count_	= shared_count->dec();
		int host_addr_		= host_addr->dec();
		int success_		= success->dec();
		int hit_			= hit->dec();

		stringstream s;
		s<<"ID:"<<id_<<", ";

		if(is_unlock_ == 0 && lock_ == 0){
			s<<"Lock S   ";
		}else if(is_unlock_ == 0 && lock_ == 1){
			s<<"Lock X   ";
		}else if(is_unlock_ == 1 && lock_ == 0){
			s<<"Unlock S ";
		}else if(is_unlock_ == 1 && lock_ == 1){
			s<<"Unlock X ";
		}

		if(success_ == 1){
			s<<" : Success ";
		}else if(hit_ == 0 || is_unlock_ == 1){
			s<<" : Error   ";
		}else{
			s<<" : Fail    ";
		}

		s<<", table:"<<tb_idx_;
		s<<", bucket:"<<bucket_idx_;
		s<<", key:"<<key_;

		if(hit_ == 1){
			s<<", slot_idx:"<<slot_idx_;
		}

		if(lock_ == 0 && success_ == 1){
			s<<", shared_count:"<<shared_count_;
		}

		return s.str();
	}
};


void bench_simple(int num_tables, int num_buckets, int slots_per_bucket);
void bench_dual_mem(int num_tables, int num_buckets, int slots_per_bucket);
void bench_block_handler(int num_tables, int num_buckets, int slots_per_bucket);
Req process_request(Req &req, vector<vector<Bucket>>& memory, int depth);
void store_table(vector<vector<Bucket>> tables, string file_name);
void load_sim_res(int num_tables, vector<vector<int>> &seq, vector<Result> &results);
void execute_cpp_sim(vector<Req> &reqs, vector<vector<int>> &input_seqs, vector<std::vector<Bucket>> &tables, vector<Result> &results_cpp);
void verify_results(vector<Result> &results_cpp, vector<Result> &results_rtl);
void print_by_table(vector<vector<int>> &input_seqs, vector<Req> reqs, vector<Result> &results_cpp, vector<Result> &results_rtl);
void print_by_group(vector<vector <Req>> &req_group, vector<Req> &reqs, vector<Result> &results_cpp, vector<Result> &results_rtl, vector<string>msgs);
#endif
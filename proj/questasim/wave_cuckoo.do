onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_cuckoo/clock
add wave -noupdate /tb_cuckoo/reset
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_ready
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_tb_idx
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_bucket_idx_raw
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_bucket_idx
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_lock
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_is_unlock
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_id
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_len
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_req_last
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_0_host_addr
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_0_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_0_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_1_host_addr
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_1_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_1_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_2_host_addr
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_2_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_2_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_3_host_addr
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_3_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_3_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_4_host_addr
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_4_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_4_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_5_host_addr
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_5_key
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_slots_5_valid
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_has_next
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_next_idx
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_exclusive_state_0
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_exclusive_state_1
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_exclusive_state_2
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_exclusive_state_3
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_exclusive_state_4
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_exclusive_state_5
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_shared_count_0
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_shared_count_1
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_shared_count_2
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_shared_count_3
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_shared_count_4
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_out_bits_bucket_shared_count_5
add wave -noupdate /tb_cuckoo/CUCKOO_inst/lock_handlers_0/q_raw_data_io_almostfull
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_aw_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_ar_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_r_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_r_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_r_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_r_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_r_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_r_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_w_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_w_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_w_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_w_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_w_bits_strb
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_b_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_b_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_b_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_0_b_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_aw_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_ar_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_r_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_r_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_r_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_r_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_r_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_r_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_w_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_w_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_w_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_w_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_w_bits_strb
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_b_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_b_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_b_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_1_b_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_aw_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_ar_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_r_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_r_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_r_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_r_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_r_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_r_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_w_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_w_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_w_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_w_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_w_bits_strb
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_b_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_b_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_b_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_2_b_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_aw_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_addr
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_burst
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_cache
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_len
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_lock
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_prot
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_qos
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_region
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_ar_bits_size
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_r_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_r_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_r_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_r_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_r_bits_resp
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_r_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_w_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_w_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_w_bits_data
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_w_bits_last
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_w_bits_strb
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_b_ready
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_b_valid
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_b_bits_id
add wave -noupdate -group axi_hbm /tb_cuckoo/io_axi_hbm_3_b_bits_resp
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_ready
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_valid
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_bits_success
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_bits_slot_idx
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_bits_shared_count
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_bits_host_addr
add wave -noupdate -group fail_0 /tb_cuckoo/io_res_failed_0_bits_hit
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_valid
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_ready
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_bits_success
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_bits_slot_idx
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_bits_shared_count
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_bits_host_addr
add wave -noupdate -group success_0 /tb_cuckoo/io_res_success_0_bits_hit
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_id
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_bucket_idx_raw
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_bucket_idx
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_ready
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_valid
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_host_addr
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_slot_idx
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_success
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_hit
add wave -noupdate -expand -group error0 /tb_cuckoo/io_res_error_0_bits_shared_count
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_ready
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_valid
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_bits_host_addr
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_bits_slot_idx
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_bits_success
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_bits_hit
add wave -noupdate -group error1 /tb_cuckoo/io_res_error_1_bits_shared_count
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_valid
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_ready
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_bits_success
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_bits_slot_idx
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_bits_shared_count
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_bits_host_addr
add wave -noupdate -group fail_1 /tb_cuckoo/io_res_failed_1_bits_hit
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_valid
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_ready
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_bits_success
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_bits_slot_idx
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_bits_shared_count
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_bits_host_addr
add wave -noupdate -group success_1 /tb_cuckoo/io_res_success_1_bits_hit
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_valid
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_ready
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_bits_success
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_bits_slot_idx
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_bits_shared_count
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_bits_host_addr
add wave -noupdate -group fail_2 /tb_cuckoo/io_res_failed_2_bits_hit
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_valid
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_ready
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_bits_success
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_bits_slot_idx
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_bits_shared_count
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_bits_host_addr
add wave -noupdate -group success_2 /tb_cuckoo/io_res_success_2_bits_hit
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_valid
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_ready
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_bits_success
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_bits_slot_idx
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_bits_shared_count
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_bits_host_addr
add wave -noupdate -group fail_3 /tb_cuckoo/io_res_failed_3_bits_hit
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_valid
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_ready
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_bits_success
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_bits_slot_idx
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_bits_shared_count
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_bits_host_addr
add wave -noupdate -group success_3 /tb_cuckoo/io_res_success_3_bits_hit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1824896 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 401
configure wave -valuecolwidth 400
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5250 ns}

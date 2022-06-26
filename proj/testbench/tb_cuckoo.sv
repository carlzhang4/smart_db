`timescale 1ns / 1ps

import "DPI-C" string_sv2c=function void string_sv2c();

module tb_cuckoo(

    );
reg                 clock                         =0;
reg                 reset                         =0;
wire                io_req_ready                  ;
reg                 io_req_valid                  =0;
reg       [59:0]    io_req_bits_key               =0;
reg       [1:0]     io_req_bits_tb_idx            =0;
reg       [32:0]    io_req_bits_bucket_idx_raw    =0;
reg       [32:0]    io_req_bits_bucket_idx        =0;
reg       [1:0]     io_req_bits_lock              =0;
reg                 io_req_bits_is_unlock         =0;
reg       [31:0]    io_req_bits_id                =0;
reg       [3:0]     io_req_bits_len               =0;
reg                 io_req_bits_last              =0;
reg       [2:0]     io_req_bits_slot_idx          =0;
reg       [7:0]     io_req_bits_shared_count      =0;
reg       [63:0]    io_req_bits_host_addr         =0;
reg                 io_req_bits_success           =0;
reg                 io_req_bits_hit               =0;
reg                 io_res_failed_0_ready         =0;
wire                io_res_failed_0_valid         ;
wire      [59:0]    io_res_failed_0_bits_key      ;
wire      [1:0]     io_res_failed_0_bits_tb_idx   ;
wire      [32:0]    io_res_failed_0_bits_bucket_idx_raw;
wire      [32:0]    io_res_failed_0_bits_bucket_idx;
wire      [1:0]     io_res_failed_0_bits_lock     ;
wire                io_res_failed_0_bits_is_unlock;
wire      [31:0]    io_res_failed_0_bits_id       ;
wire      [3:0]     io_res_failed_0_bits_len      ;
wire                io_res_failed_0_bits_last     ;
wire      [2:0]     io_res_failed_0_bits_slot_idx ;
wire      [7:0]     io_res_failed_0_bits_shared_count;
wire      [63:0]    io_res_failed_0_bits_host_addr;
wire                io_res_failed_0_bits_success  ;
wire                io_res_failed_0_bits_hit      ;
reg                 io_res_failed_1_ready         =0;
wire                io_res_failed_1_valid         ;
wire      [59:0]    io_res_failed_1_bits_key      ;
wire      [1:0]     io_res_failed_1_bits_tb_idx   ;
wire      [32:0]    io_res_failed_1_bits_bucket_idx_raw;
wire      [32:0]    io_res_failed_1_bits_bucket_idx;
wire      [1:0]     io_res_failed_1_bits_lock     ;
wire                io_res_failed_1_bits_is_unlock;
wire      [31:0]    io_res_failed_1_bits_id       ;
wire      [3:0]     io_res_failed_1_bits_len      ;
wire                io_res_failed_1_bits_last     ;
wire      [2:0]     io_res_failed_1_bits_slot_idx ;
wire      [7:0]     io_res_failed_1_bits_shared_count;
wire      [63:0]    io_res_failed_1_bits_host_addr;
wire                io_res_failed_1_bits_success  ;
wire                io_res_failed_1_bits_hit      ;
reg                 io_res_failed_2_ready         =0;
wire                io_res_failed_2_valid         ;
wire      [59:0]    io_res_failed_2_bits_key      ;
wire      [1:0]     io_res_failed_2_bits_tb_idx   ;
wire      [32:0]    io_res_failed_2_bits_bucket_idx_raw;
wire      [32:0]    io_res_failed_2_bits_bucket_idx;
wire      [1:0]     io_res_failed_2_bits_lock     ;
wire                io_res_failed_2_bits_is_unlock;
wire      [31:0]    io_res_failed_2_bits_id       ;
wire      [3:0]     io_res_failed_2_bits_len      ;
wire                io_res_failed_2_bits_last     ;
wire      [2:0]     io_res_failed_2_bits_slot_idx ;
wire      [7:0]     io_res_failed_2_bits_shared_count;
wire      [63:0]    io_res_failed_2_bits_host_addr;
wire                io_res_failed_2_bits_success  ;
wire                io_res_failed_2_bits_hit      ;
reg                 io_res_failed_3_ready         =0;
wire                io_res_failed_3_valid         ;
wire      [59:0]    io_res_failed_3_bits_key      ;
wire      [1:0]     io_res_failed_3_bits_tb_idx   ;
wire      [32:0]    io_res_failed_3_bits_bucket_idx_raw;
wire      [32:0]    io_res_failed_3_bits_bucket_idx;
wire      [1:0]     io_res_failed_3_bits_lock     ;
wire                io_res_failed_3_bits_is_unlock;
wire      [31:0]    io_res_failed_3_bits_id       ;
wire      [3:0]     io_res_failed_3_bits_len      ;
wire                io_res_failed_3_bits_last     ;
wire      [2:0]     io_res_failed_3_bits_slot_idx ;
wire      [7:0]     io_res_failed_3_bits_shared_count;
wire      [63:0]    io_res_failed_3_bits_host_addr;
wire                io_res_failed_3_bits_success  ;
wire                io_res_failed_3_bits_hit      ;
reg                 io_res_error_0_ready          =0;
wire                io_res_error_0_valid          ;
wire      [59:0]    io_res_error_0_bits_key       ;
wire      [1:0]     io_res_error_0_bits_tb_idx    ;
wire      [32:0]    io_res_error_0_bits_bucket_idx_raw;
wire      [32:0]    io_res_error_0_bits_bucket_idx;
wire      [1:0]     io_res_error_0_bits_lock      ;
wire                io_res_error_0_bits_is_unlock ;
wire      [31:0]    io_res_error_0_bits_id        ;
wire      [3:0]     io_res_error_0_bits_len       ;
wire                io_res_error_0_bits_last      ;
wire      [2:0]     io_res_error_0_bits_slot_idx  ;
wire      [7:0]     io_res_error_0_bits_shared_count;
wire      [63:0]    io_res_error_0_bits_host_addr ;
wire                io_res_error_0_bits_success   ;
wire                io_res_error_0_bits_hit       ;
reg                 io_res_error_1_ready          =0;
wire                io_res_error_1_valid          ;
wire      [59:0]    io_res_error_1_bits_key       ;
wire      [1:0]     io_res_error_1_bits_tb_idx    ;
wire      [32:0]    io_res_error_1_bits_bucket_idx_raw;
wire      [32:0]    io_res_error_1_bits_bucket_idx;
wire      [1:0]     io_res_error_1_bits_lock      ;
wire                io_res_error_1_bits_is_unlock ;
wire      [31:0]    io_res_error_1_bits_id        ;
wire      [3:0]     io_res_error_1_bits_len       ;
wire                io_res_error_1_bits_last      ;
wire      [2:0]     io_res_error_1_bits_slot_idx  ;
wire      [7:0]     io_res_error_1_bits_shared_count;
wire      [63:0]    io_res_error_1_bits_host_addr ;
wire                io_res_error_1_bits_success   ;
wire                io_res_error_1_bits_hit       ;
reg                 io_res_error_2_ready          =0;
wire                io_res_error_2_valid          ;
wire      [59:0]    io_res_error_2_bits_key       ;
wire      [1:0]     io_res_error_2_bits_tb_idx    ;
wire      [32:0]    io_res_error_2_bits_bucket_idx_raw;
wire      [32:0]    io_res_error_2_bits_bucket_idx;
wire      [1:0]     io_res_error_2_bits_lock      ;
wire                io_res_error_2_bits_is_unlock ;
wire      [31:0]    io_res_error_2_bits_id        ;
wire      [3:0]     io_res_error_2_bits_len       ;
wire                io_res_error_2_bits_last      ;
wire      [2:0]     io_res_error_2_bits_slot_idx  ;
wire      [7:0]     io_res_error_2_bits_shared_count;
wire      [63:0]    io_res_error_2_bits_host_addr ;
wire                io_res_error_2_bits_success   ;
wire                io_res_error_2_bits_hit       ;
reg                 io_res_error_3_ready          =0;
wire                io_res_error_3_valid          ;
wire      [59:0]    io_res_error_3_bits_key       ;
wire      [1:0]     io_res_error_3_bits_tb_idx    ;
wire      [32:0]    io_res_error_3_bits_bucket_idx_raw;
wire      [32:0]    io_res_error_3_bits_bucket_idx;
wire      [1:0]     io_res_error_3_bits_lock      ;
wire                io_res_error_3_bits_is_unlock ;
wire      [31:0]    io_res_error_3_bits_id        ;
wire      [3:0]     io_res_error_3_bits_len       ;
wire                io_res_error_3_bits_last      ;
wire      [2:0]     io_res_error_3_bits_slot_idx  ;
wire      [7:0]     io_res_error_3_bits_shared_count;
wire      [63:0]    io_res_error_3_bits_host_addr ;
wire                io_res_error_3_bits_success   ;
wire                io_res_error_3_bits_hit       ;
reg                 io_res_success_0_ready        =0;
wire                io_res_success_0_valid        ;
wire      [59:0]    io_res_success_0_bits_key     ;
wire      [1:0]     io_res_success_0_bits_tb_idx  ;
wire      [32:0]    io_res_success_0_bits_bucket_idx_raw;
wire      [32:0]    io_res_success_0_bits_bucket_idx;
wire      [1:0]     io_res_success_0_bits_lock    ;
wire                io_res_success_0_bits_is_unlock;
wire      [31:0]    io_res_success_0_bits_id      ;
wire      [3:0]     io_res_success_0_bits_len     ;
wire                io_res_success_0_bits_last    ;
wire      [2:0]     io_res_success_0_bits_slot_idx;
wire      [7:0]     io_res_success_0_bits_shared_count;
wire      [63:0]    io_res_success_0_bits_host_addr;
wire                io_res_success_0_bits_success ;
wire                io_res_success_0_bits_hit     ;
reg                 io_res_success_1_ready        =0;
wire                io_res_success_1_valid        ;
wire      [59:0]    io_res_success_1_bits_key     ;
wire      [1:0]     io_res_success_1_bits_tb_idx  ;
wire      [32:0]    io_res_success_1_bits_bucket_idx_raw;
wire      [32:0]    io_res_success_1_bits_bucket_idx;
wire      [1:0]     io_res_success_1_bits_lock    ;
wire                io_res_success_1_bits_is_unlock;
wire      [31:0]    io_res_success_1_bits_id      ;
wire      [3:0]     io_res_success_1_bits_len     ;
wire                io_res_success_1_bits_last    ;
wire      [2:0]     io_res_success_1_bits_slot_idx;
wire      [7:0]     io_res_success_1_bits_shared_count;
wire      [63:0]    io_res_success_1_bits_host_addr;
wire                io_res_success_1_bits_success ;
wire                io_res_success_1_bits_hit     ;
reg                 io_res_success_2_ready        =0;
wire                io_res_success_2_valid        ;
wire      [59:0]    io_res_success_2_bits_key     ;
wire      [1:0]     io_res_success_2_bits_tb_idx  ;
wire      [32:0]    io_res_success_2_bits_bucket_idx_raw;
wire      [32:0]    io_res_success_2_bits_bucket_idx;
wire      [1:0]     io_res_success_2_bits_lock    ;
wire                io_res_success_2_bits_is_unlock;
wire      [31:0]    io_res_success_2_bits_id      ;
wire      [3:0]     io_res_success_2_bits_len     ;
wire                io_res_success_2_bits_last    ;
wire      [2:0]     io_res_success_2_bits_slot_idx;
wire      [7:0]     io_res_success_2_bits_shared_count;
wire      [63:0]    io_res_success_2_bits_host_addr;
wire                io_res_success_2_bits_success ;
wire                io_res_success_2_bits_hit     ;
reg                 io_res_success_3_ready        =0;
wire                io_res_success_3_valid        ;
wire      [59:0]    io_res_success_3_bits_key     ;
wire      [1:0]     io_res_success_3_bits_tb_idx  ;
wire      [32:0]    io_res_success_3_bits_bucket_idx_raw;
wire      [32:0]    io_res_success_3_bits_bucket_idx;
wire      [1:0]     io_res_success_3_bits_lock    ;
wire                io_res_success_3_bits_is_unlock;
wire      [31:0]    io_res_success_3_bits_id      ;
wire      [3:0]     io_res_success_3_bits_len     ;
wire                io_res_success_3_bits_last    ;
wire      [2:0]     io_res_success_3_bits_slot_idx;
wire      [7:0]     io_res_success_3_bits_shared_count;
wire      [63:0]    io_res_success_3_bits_host_addr;
wire                io_res_success_3_bits_success ;
wire                io_res_success_3_bits_hit     ;
reg                 io_axi_hbm_0_aw_ready         =0;
wire                io_axi_hbm_0_aw_valid         ;
wire      [32:0]    io_axi_hbm_0_aw_bits_addr     ;
wire      [1:0]     io_axi_hbm_0_aw_bits_burst    ;
wire      [3:0]     io_axi_hbm_0_aw_bits_cache    ;
wire      [5:0]     io_axi_hbm_0_aw_bits_id       ;
wire      [3:0]     io_axi_hbm_0_aw_bits_len      ;
wire                io_axi_hbm_0_aw_bits_lock     ;
wire      [2:0]     io_axi_hbm_0_aw_bits_prot     ;
wire      [3:0]     io_axi_hbm_0_aw_bits_qos      ;
wire      [3:0]     io_axi_hbm_0_aw_bits_region   ;
wire      [2:0]     io_axi_hbm_0_aw_bits_size     ;
reg                 io_axi_hbm_0_ar_ready         =0;
wire                io_axi_hbm_0_ar_valid         ;
wire      [32:0]    io_axi_hbm_0_ar_bits_addr     ;
wire      [1:0]     io_axi_hbm_0_ar_bits_burst    ;
wire      [3:0]     io_axi_hbm_0_ar_bits_cache    ;
wire      [5:0]     io_axi_hbm_0_ar_bits_id       ;
wire      [3:0]     io_axi_hbm_0_ar_bits_len      ;
wire                io_axi_hbm_0_ar_bits_lock     ;
wire      [2:0]     io_axi_hbm_0_ar_bits_prot     ;
wire      [3:0]     io_axi_hbm_0_ar_bits_qos      ;
wire      [3:0]     io_axi_hbm_0_ar_bits_region   ;
wire      [2:0]     io_axi_hbm_0_ar_bits_size     ;
wire                io_axi_hbm_0_r_ready          ;
reg                 io_axi_hbm_0_r_valid          =0;
reg       [255:0]   io_axi_hbm_0_r_bits_data      =0;
reg                 io_axi_hbm_0_r_bits_last      =0;
reg       [1:0]     io_axi_hbm_0_r_bits_resp      =0;
reg       [5:0]     io_axi_hbm_0_r_bits_id        =0;
reg                 io_axi_hbm_0_w_ready          =0;
wire                io_axi_hbm_0_w_valid          ;
wire      [255:0]   io_axi_hbm_0_w_bits_data      ;
wire                io_axi_hbm_0_w_bits_last      ;
wire      [31:0]    io_axi_hbm_0_w_bits_strb      ;
wire                io_axi_hbm_0_b_ready          ;
reg                 io_axi_hbm_0_b_valid          =0;
reg       [5:0]     io_axi_hbm_0_b_bits_id        =0;
reg       [1:0]     io_axi_hbm_0_b_bits_resp      =0;
reg                 io_axi_hbm_1_aw_ready         =0;
wire                io_axi_hbm_1_aw_valid         ;
wire      [32:0]    io_axi_hbm_1_aw_bits_addr     ;
wire      [1:0]     io_axi_hbm_1_aw_bits_burst    ;
wire      [3:0]     io_axi_hbm_1_aw_bits_cache    ;
wire      [5:0]     io_axi_hbm_1_aw_bits_id       ;
wire      [3:0]     io_axi_hbm_1_aw_bits_len      ;
wire                io_axi_hbm_1_aw_bits_lock     ;
wire      [2:0]     io_axi_hbm_1_aw_bits_prot     ;
wire      [3:0]     io_axi_hbm_1_aw_bits_qos      ;
wire      [3:0]     io_axi_hbm_1_aw_bits_region   ;
wire      [2:0]     io_axi_hbm_1_aw_bits_size     ;
reg                 io_axi_hbm_1_ar_ready         =0;
wire                io_axi_hbm_1_ar_valid         ;
wire      [32:0]    io_axi_hbm_1_ar_bits_addr     ;
wire      [1:0]     io_axi_hbm_1_ar_bits_burst    ;
wire      [3:0]     io_axi_hbm_1_ar_bits_cache    ;
wire      [5:0]     io_axi_hbm_1_ar_bits_id       ;
wire      [3:0]     io_axi_hbm_1_ar_bits_len      ;
wire                io_axi_hbm_1_ar_bits_lock     ;
wire      [2:0]     io_axi_hbm_1_ar_bits_prot     ;
wire      [3:0]     io_axi_hbm_1_ar_bits_qos      ;
wire      [3:0]     io_axi_hbm_1_ar_bits_region   ;
wire      [2:0]     io_axi_hbm_1_ar_bits_size     ;
wire                io_axi_hbm_1_r_ready          ;
reg                 io_axi_hbm_1_r_valid          =0;
reg       [255:0]   io_axi_hbm_1_r_bits_data      =0;
reg                 io_axi_hbm_1_r_bits_last      =0;
reg       [1:0]     io_axi_hbm_1_r_bits_resp      =0;
reg       [5:0]     io_axi_hbm_1_r_bits_id        =0;
reg                 io_axi_hbm_1_w_ready          =0;
wire                io_axi_hbm_1_w_valid          ;
wire      [255:0]   io_axi_hbm_1_w_bits_data      ;
wire                io_axi_hbm_1_w_bits_last      ;
wire      [31:0]    io_axi_hbm_1_w_bits_strb      ;
wire                io_axi_hbm_1_b_ready          ;
reg                 io_axi_hbm_1_b_valid          =0;
reg       [5:0]     io_axi_hbm_1_b_bits_id        =0;
reg       [1:0]     io_axi_hbm_1_b_bits_resp      =0;
reg                 io_axi_hbm_2_aw_ready         =0;
wire                io_axi_hbm_2_aw_valid         ;
wire      [32:0]    io_axi_hbm_2_aw_bits_addr     ;
wire      [1:0]     io_axi_hbm_2_aw_bits_burst    ;
wire      [3:0]     io_axi_hbm_2_aw_bits_cache    ;
wire      [5:0]     io_axi_hbm_2_aw_bits_id       ;
wire      [3:0]     io_axi_hbm_2_aw_bits_len      ;
wire                io_axi_hbm_2_aw_bits_lock     ;
wire      [2:0]     io_axi_hbm_2_aw_bits_prot     ;
wire      [3:0]     io_axi_hbm_2_aw_bits_qos      ;
wire      [3:0]     io_axi_hbm_2_aw_bits_region   ;
wire      [2:0]     io_axi_hbm_2_aw_bits_size     ;
reg                 io_axi_hbm_2_ar_ready         =0;
wire                io_axi_hbm_2_ar_valid         ;
wire      [32:0]    io_axi_hbm_2_ar_bits_addr     ;
wire      [1:0]     io_axi_hbm_2_ar_bits_burst    ;
wire      [3:0]     io_axi_hbm_2_ar_bits_cache    ;
wire      [5:0]     io_axi_hbm_2_ar_bits_id       ;
wire      [3:0]     io_axi_hbm_2_ar_bits_len      ;
wire                io_axi_hbm_2_ar_bits_lock     ;
wire      [2:0]     io_axi_hbm_2_ar_bits_prot     ;
wire      [3:0]     io_axi_hbm_2_ar_bits_qos      ;
wire      [3:0]     io_axi_hbm_2_ar_bits_region   ;
wire      [2:0]     io_axi_hbm_2_ar_bits_size     ;
wire                io_axi_hbm_2_r_ready          ;
reg                 io_axi_hbm_2_r_valid          =0;
reg       [255:0]   io_axi_hbm_2_r_bits_data      =0;
reg                 io_axi_hbm_2_r_bits_last      =0;
reg       [1:0]     io_axi_hbm_2_r_bits_resp      =0;
reg       [5:0]     io_axi_hbm_2_r_bits_id        =0;
reg                 io_axi_hbm_2_w_ready          =0;
wire                io_axi_hbm_2_w_valid          ;
wire      [255:0]   io_axi_hbm_2_w_bits_data      ;
wire                io_axi_hbm_2_w_bits_last      ;
wire      [31:0]    io_axi_hbm_2_w_bits_strb      ;
wire                io_axi_hbm_2_b_ready          ;
reg                 io_axi_hbm_2_b_valid          =0;
reg       [5:0]     io_axi_hbm_2_b_bits_id        =0;
reg       [1:0]     io_axi_hbm_2_b_bits_resp      =0;
reg                 io_axi_hbm_3_aw_ready         =0;
wire                io_axi_hbm_3_aw_valid         ;
wire      [32:0]    io_axi_hbm_3_aw_bits_addr     ;
wire      [1:0]     io_axi_hbm_3_aw_bits_burst    ;
wire      [3:0]     io_axi_hbm_3_aw_bits_cache    ;
wire      [5:0]     io_axi_hbm_3_aw_bits_id       ;
wire      [3:0]     io_axi_hbm_3_aw_bits_len      ;
wire                io_axi_hbm_3_aw_bits_lock     ;
wire      [2:0]     io_axi_hbm_3_aw_bits_prot     ;
wire      [3:0]     io_axi_hbm_3_aw_bits_qos      ;
wire      [3:0]     io_axi_hbm_3_aw_bits_region   ;
wire      [2:0]     io_axi_hbm_3_aw_bits_size     ;
reg                 io_axi_hbm_3_ar_ready         =0;
wire                io_axi_hbm_3_ar_valid         ;
wire      [32:0]    io_axi_hbm_3_ar_bits_addr     ;
wire      [1:0]     io_axi_hbm_3_ar_bits_burst    ;
wire      [3:0]     io_axi_hbm_3_ar_bits_cache    ;
wire      [5:0]     io_axi_hbm_3_ar_bits_id       ;
wire      [3:0]     io_axi_hbm_3_ar_bits_len      ;
wire                io_axi_hbm_3_ar_bits_lock     ;
wire      [2:0]     io_axi_hbm_3_ar_bits_prot     ;
wire      [3:0]     io_axi_hbm_3_ar_bits_qos      ;
wire      [3:0]     io_axi_hbm_3_ar_bits_region   ;
wire      [2:0]     io_axi_hbm_3_ar_bits_size     ;
wire                io_axi_hbm_3_r_ready          ;
reg                 io_axi_hbm_3_r_valid          =0;
reg       [255:0]   io_axi_hbm_3_r_bits_data      =0;
reg                 io_axi_hbm_3_r_bits_last      =0;
reg       [1:0]     io_axi_hbm_3_r_bits_resp      =0;
reg       [5:0]     io_axi_hbm_3_r_bits_id        =0;
reg                 io_axi_hbm_3_w_ready          =0;
wire                io_axi_hbm_3_w_valid          ;
wire      [255:0]   io_axi_hbm_3_w_bits_data      ;
wire                io_axi_hbm_3_w_bits_last      ;
wire      [31:0]    io_axi_hbm_3_w_bits_strb      ;
wire                io_axi_hbm_3_b_ready          ;
reg                 io_axi_hbm_3_b_valid          =0;
reg       [5:0]     io_axi_hbm_3_b_bits_id        =0;
reg       [1:0]     io_axi_hbm_3_b_bits_resp      =0;
reg                 io_inits_init_en_0            =0;
reg                 io_inits_init_en_1            =0;
reg                 io_inits_init_en_2            =0;
reg                 io_inits_init_en_3            =0;
reg       [9:0]     io_inits_addr_a_0             =0;
reg       [9:0]     io_inits_addr_a_1             =0;
reg       [9:0]     io_inits_addr_a_2             =0;
reg       [9:0]     io_inits_addr_a_3             =0;
reg                 io_inits_wr_en_a_0            =0;
reg                 io_inits_wr_en_a_1            =0;
reg                 io_inits_wr_en_a_2            =0;
reg                 io_inits_wr_en_a_3            =0;
reg       [1023:0]  io_inits_data_in_a_0          =0;
reg       [1023:0]  io_inits_data_in_a_1          =0;
reg       [1023:0]  io_inits_data_in_a_2          =0;
reg       [1023:0]  io_inits_data_in_a_3          =0;
wire      [31:0]    io_reports                    ;

IN#(245)in_io_req(
        clock,
        reset,
        {io_req_bits_key,io_req_bits_tb_idx,io_req_bits_bucket_idx_raw,io_req_bits_bucket_idx,io_req_bits_lock,io_req_bits_is_unlock,io_req_bits_id,io_req_bits_len,io_req_bits_last,io_req_bits_slot_idx,io_req_bits_shared_count,io_req_bits_host_addr,io_req_bits_success,io_req_bits_hit},
        io_req_valid,
        io_req_ready
);

OUT#(245)out_io_res_failed_0(
        clock,
        reset,
        {io_res_failed_0_bits_key,io_res_failed_0_bits_tb_idx,io_res_failed_0_bits_bucket_idx_raw,io_res_failed_0_bits_bucket_idx,io_res_failed_0_bits_lock,io_res_failed_0_bits_is_unlock,io_res_failed_0_bits_id,io_res_failed_0_bits_len,io_res_failed_0_bits_last,io_res_failed_0_bits_slot_idx,io_res_failed_0_bits_shared_count,io_res_failed_0_bits_host_addr,io_res_failed_0_bits_success,io_res_failed_0_bits_hit},
        io_res_failed_0_valid,
        io_res_failed_0_ready
);

OUT#(245)out_io_res_failed_1(
        clock,
        reset,
        {io_res_failed_1_bits_key,io_res_failed_1_bits_tb_idx,io_res_failed_1_bits_bucket_idx_raw,io_res_failed_1_bits_bucket_idx,io_res_failed_1_bits_lock,io_res_failed_1_bits_is_unlock,io_res_failed_1_bits_id,io_res_failed_1_bits_len,io_res_failed_1_bits_last,io_res_failed_1_bits_slot_idx,io_res_failed_1_bits_shared_count,io_res_failed_1_bits_host_addr,io_res_failed_1_bits_success,io_res_failed_1_bits_hit},
        io_res_failed_1_valid,
        io_res_failed_1_ready
);

OUT#(245)out_io_res_failed_2(
        clock,
        reset,
        {io_res_failed_2_bits_key,io_res_failed_2_bits_tb_idx,io_res_failed_2_bits_bucket_idx_raw,io_res_failed_2_bits_bucket_idx,io_res_failed_2_bits_lock,io_res_failed_2_bits_is_unlock,io_res_failed_2_bits_id,io_res_failed_2_bits_len,io_res_failed_2_bits_last,io_res_failed_2_bits_slot_idx,io_res_failed_2_bits_shared_count,io_res_failed_2_bits_host_addr,io_res_failed_2_bits_success,io_res_failed_2_bits_hit},
        io_res_failed_2_valid,
        io_res_failed_2_ready
);

OUT#(245)out_io_res_failed_3(
        clock,
        reset,
        {io_res_failed_3_bits_key,io_res_failed_3_bits_tb_idx,io_res_failed_3_bits_bucket_idx_raw,io_res_failed_3_bits_bucket_idx,io_res_failed_3_bits_lock,io_res_failed_3_bits_is_unlock,io_res_failed_3_bits_id,io_res_failed_3_bits_len,io_res_failed_3_bits_last,io_res_failed_3_bits_slot_idx,io_res_failed_3_bits_shared_count,io_res_failed_3_bits_host_addr,io_res_failed_3_bits_success,io_res_failed_3_bits_hit},
        io_res_failed_3_valid,
        io_res_failed_3_ready
);

OUT#(245)out_io_res_error_0(
        clock,
        reset,
        {io_res_error_0_bits_key,io_res_error_0_bits_tb_idx,io_res_error_0_bits_bucket_idx_raw,io_res_error_0_bits_bucket_idx,io_res_error_0_bits_lock,io_res_error_0_bits_is_unlock,io_res_error_0_bits_id,io_res_error_0_bits_len,io_res_error_0_bits_last,io_res_error_0_bits_slot_idx,io_res_error_0_bits_shared_count,io_res_error_0_bits_host_addr,io_res_error_0_bits_success,io_res_error_0_bits_hit},
        io_res_error_0_valid,
        io_res_error_0_ready
);

OUT#(245)out_io_res_error_1(
        clock,
        reset,
        {io_res_error_1_bits_key,io_res_error_1_bits_tb_idx,io_res_error_1_bits_bucket_idx_raw,io_res_error_1_bits_bucket_idx,io_res_error_1_bits_lock,io_res_error_1_bits_is_unlock,io_res_error_1_bits_id,io_res_error_1_bits_len,io_res_error_1_bits_last,io_res_error_1_bits_slot_idx,io_res_error_1_bits_shared_count,io_res_error_1_bits_host_addr,io_res_error_1_bits_success,io_res_error_1_bits_hit},
        io_res_error_1_valid,
        io_res_error_1_ready
);

OUT#(245)out_io_res_error_2(
        clock,
        reset,
        {io_res_error_2_bits_key,io_res_error_2_bits_tb_idx,io_res_error_2_bits_bucket_idx_raw,io_res_error_2_bits_bucket_idx,io_res_error_2_bits_lock,io_res_error_2_bits_is_unlock,io_res_error_2_bits_id,io_res_error_2_bits_len,io_res_error_2_bits_last,io_res_error_2_bits_slot_idx,io_res_error_2_bits_shared_count,io_res_error_2_bits_host_addr,io_res_error_2_bits_success,io_res_error_2_bits_hit},
        io_res_error_2_valid,
        io_res_error_2_ready
);

OUT#(245)out_io_res_error_3(
        clock,
        reset,
        {io_res_error_3_bits_key,io_res_error_3_bits_tb_idx,io_res_error_3_bits_bucket_idx_raw,io_res_error_3_bits_bucket_idx,io_res_error_3_bits_lock,io_res_error_3_bits_is_unlock,io_res_error_3_bits_id,io_res_error_3_bits_len,io_res_error_3_bits_last,io_res_error_3_bits_slot_idx,io_res_error_3_bits_shared_count,io_res_error_3_bits_host_addr,io_res_error_3_bits_success,io_res_error_3_bits_hit},
        io_res_error_3_valid,
        io_res_error_3_ready
);

OUT#(245)out_io_res_success_0(
        clock,
        reset,
        {io_res_success_0_bits_key,io_res_success_0_bits_tb_idx,io_res_success_0_bits_bucket_idx_raw,io_res_success_0_bits_bucket_idx,io_res_success_0_bits_lock,io_res_success_0_bits_is_unlock,io_res_success_0_bits_id,io_res_success_0_bits_len,io_res_success_0_bits_last,io_res_success_0_bits_slot_idx,io_res_success_0_bits_shared_count,io_res_success_0_bits_host_addr,io_res_success_0_bits_success,io_res_success_0_bits_hit},
        io_res_success_0_valid,
        io_res_success_0_ready
);

OUT#(245)out_io_res_success_1(
        clock,
        reset,
        {io_res_success_1_bits_key,io_res_success_1_bits_tb_idx,io_res_success_1_bits_bucket_idx_raw,io_res_success_1_bits_bucket_idx,io_res_success_1_bits_lock,io_res_success_1_bits_is_unlock,io_res_success_1_bits_id,io_res_success_1_bits_len,io_res_success_1_bits_last,io_res_success_1_bits_slot_idx,io_res_success_1_bits_shared_count,io_res_success_1_bits_host_addr,io_res_success_1_bits_success,io_res_success_1_bits_hit},
        io_res_success_1_valid,
        io_res_success_1_ready
);

OUT#(245)out_io_res_success_2(
        clock,
        reset,
        {io_res_success_2_bits_key,io_res_success_2_bits_tb_idx,io_res_success_2_bits_bucket_idx_raw,io_res_success_2_bits_bucket_idx,io_res_success_2_bits_lock,io_res_success_2_bits_is_unlock,io_res_success_2_bits_id,io_res_success_2_bits_len,io_res_success_2_bits_last,io_res_success_2_bits_slot_idx,io_res_success_2_bits_shared_count,io_res_success_2_bits_host_addr,io_res_success_2_bits_success,io_res_success_2_bits_hit},
        io_res_success_2_valid,
        io_res_success_2_ready
);

OUT#(245)out_io_res_success_3(
        clock,
        reset,
        {io_res_success_3_bits_key,io_res_success_3_bits_tb_idx,io_res_success_3_bits_bucket_idx_raw,io_res_success_3_bits_bucket_idx,io_res_success_3_bits_lock,io_res_success_3_bits_is_unlock,io_res_success_3_bits_id,io_res_success_3_bits_len,io_res_success_3_bits_last,io_res_success_3_bits_slot_idx,io_res_success_3_bits_shared_count,io_res_success_3_bits_host_addr,io_res_success_3_bits_success,io_res_success_3_bits_hit},
        io_res_success_3_valid,
        io_res_success_3_ready
);
CUCKOO CUCKOO_inst(
	.*
);


DMA#(256,10) hbm0(
.clock                         (clock                         ),//input 
.reset                         (reset                         ),//input 
.read_cmd_valid                (io_axi_hbm_0_ar_valid                ),//input 
.read_cmd_ready                (io_axi_hbm_0_ar_ready                ),//output 
.read_cmd_address              (io_axi_hbm_0_ar_bits_addr              ),//input [63:0]
.read_cmd_length               ((io_axi_hbm_0_ar_bits_len+1)<<5               ),//input [31:0]
.write_cmd_valid               (io_axi_hbm_0_aw_valid               ),//input 
.write_cmd_ready               (io_axi_hbm_0_aw_ready               ),//output 
.write_cmd_address             ({32'h0,io_axi_hbm_0_aw_bits_addr}             ),//input [63:0]
.write_cmd_length              ((io_axi_hbm_0_aw_bits_len+1)<<5              ),//input [31:0]
.read_data_valid               (io_axi_hbm_0_r_valid               ),//output 
.read_data_ready               (io_axi_hbm_0_r_ready               ),//input 
.read_data_data                (io_axi_hbm_0_r_bits_data                ),//output [width-1:0]
.read_data_keep                (                ),//output [(width/8)-1:0]
.read_data_last                (io_axi_hbm_0_r_bits_last                ),//output 
.write_data_valid              (io_axi_hbm_0_w_valid              ),//input 
.write_data_ready              (io_axi_hbm_0_w_ready              ),//output 
.write_data_data               (io_axi_hbm_0_w_bits_data               ),//input [width-1:0]
.write_data_keep               (io_axi_hbm_0_w_bits_strb               ),//input [(width/8)-1:0]
.write_data_last               (io_axi_hbm_0_w_bits_last               ),//input 
.back_valid					   (io_axi_hbm_0_b_valid),
.back_ready					   (io_axi_hbm_0_b_ready)
);

DMA#(256,10) hbm1(
.clock                         (clock                         ),//input 
.reset                         (reset                         ),//input 
.read_cmd_valid                (io_axi_hbm_1_ar_valid                ),//input 
.read_cmd_ready                (io_axi_hbm_1_ar_ready                ),//output 
.read_cmd_address              (io_axi_hbm_1_ar_bits_addr              ),//input [63:0]
.read_cmd_length               ((io_axi_hbm_1_ar_bits_len+1)<<5               ),//input [31:0]
.write_cmd_valid               (io_axi_hbm_1_aw_valid               ),//input 
.write_cmd_ready               (io_axi_hbm_1_aw_ready               ),//output 
.write_cmd_address             (io_axi_hbm_1_aw_bits_addr             ),//input [63:0]
.write_cmd_length              ((io_axi_hbm_1_aw_bits_len+1)<<5              ),//input [31:0]
.read_data_valid               (io_axi_hbm_1_r_valid               ),//output 
.read_data_ready               (io_axi_hbm_1_r_ready               ),//input 
.read_data_data                (io_axi_hbm_1_r_bits_data                ),//output [width-1:0]
.read_data_keep                (                ),//output [(width/8)-1:0]
.read_data_last                (io_axi_hbm_1_r_bits_last                ),//output 
.write_data_valid              (io_axi_hbm_1_w_valid              ),//input 
.write_data_ready              (io_axi_hbm_1_w_ready              ),//output 
.write_data_data               (io_axi_hbm_1_w_bits_data               ),//input [width-1:0]
.write_data_keep               (io_axi_hbm_1_w_bits_strb               ),//input [(width/8)-1:0]
.write_data_last               (io_axi_hbm_1_w_bits_last               ),//input 
.back_valid					   (io_axi_hbm_1_b_valid),
.back_ready					   (io_axi_hbm_1_b_ready)
);

DMA#(256,10) hbm2(
.clock                         (clock                         ),//input 
.reset                         (reset                         ),//input 
.read_cmd_valid                (io_axi_hbm_2_ar_valid                ),//input 
.read_cmd_ready                (io_axi_hbm_2_ar_ready                ),//output 
.read_cmd_address              (io_axi_hbm_2_ar_bits_addr              ),//input [63:0]
.read_cmd_length               ((io_axi_hbm_2_ar_bits_len+1)<<5               ),//input [31:0]
.write_cmd_valid               (io_axi_hbm_2_aw_valid               ),//input 
.write_cmd_ready               (io_axi_hbm_2_aw_ready               ),//output 
.write_cmd_address             (io_axi_hbm_2_aw_bits_addr             ),//input [63:0]
.write_cmd_length              ((io_axi_hbm_2_aw_bits_len+1)<<5              ),//input [31:0]
.read_data_valid               (io_axi_hbm_2_r_valid               ),//output 
.read_data_ready               (io_axi_hbm_2_r_ready               ),//input 
.read_data_data                (io_axi_hbm_2_r_bits_data                ),//output [width-1:0]
.read_data_keep                (                ),//output [(width/8)-1:0]
.read_data_last                (io_axi_hbm_2_r_bits_last                ),//output 
.write_data_valid              (io_axi_hbm_2_w_valid              ),//input 
.write_data_ready              (io_axi_hbm_2_w_ready              ),//output 
.write_data_data               (io_axi_hbm_2_w_bits_data               ),//input [width-1:0]
.write_data_keep               (io_axi_hbm_2_w_bits_strb               ),//input [(width/8)-1:0]
.write_data_last               (io_axi_hbm_2_w_bits_last               ),//input 
.back_valid					   (io_axi_hbm_2_b_valid),
.back_ready					   (io_axi_hbm_2_b_ready));

DMA#(256,10) hbm3(
.clock                         (clock                         ),//input 
.reset                         (reset                         ),//input 
.read_cmd_valid                (io_axi_hbm_3_ar_valid                ),//input 
.read_cmd_ready                (io_axi_hbm_3_ar_ready                ),//output 
.read_cmd_address              (io_axi_hbm_3_ar_bits_addr              ),//input [63:0]
.read_cmd_length               ((io_axi_hbm_3_ar_bits_len+1)<<5               ),//input [31:0]
.write_cmd_valid               (io_axi_hbm_3_aw_valid               ),//input 
.write_cmd_ready               (io_axi_hbm_3_aw_ready               ),//output 
.write_cmd_address             (io_axi_hbm_3_aw_bits_addr             ),//input [63:0]
.write_cmd_length              ((io_axi_hbm_3_aw_bits_len+1)<<5              ),//input [31:0]
.read_data_valid               (io_axi_hbm_3_r_valid               ),//output 
.read_data_ready               (io_axi_hbm_3_r_ready               ),//input 
.read_data_data                (io_axi_hbm_3_r_bits_data                ),//output [width-1:0]
.read_data_keep                (                ),//output [(width/8)-1:0]
.read_data_last                (io_axi_hbm_3_r_bits_last                ),//output 
.write_data_valid              (io_axi_hbm_3_w_valid              ),//input 
.write_data_ready              (io_axi_hbm_3_w_ready              ),//output 
.write_data_data               (io_axi_hbm_3_w_bits_data               ),//input [width-1:0]
.write_data_keep               (io_axi_hbm_3_w_bits_strb               ),//input [(width/8)-1:0]
.write_data_last               (io_axi_hbm_3_w_bits_last               ),//input 
.back_valid					   (io_axi_hbm_3_b_valid),
.back_ready					   (io_axi_hbm_3_b_ready));


	parameter bucket_num = 10;
	parameter chain_len = 2;
	bit [bucket_num*2-1:0][1024-1:0]oc_mem0;
	bit [bucket_num*2-1:0][1024-1:0]oc_mem1;
	bit [bucket_num*2-1:0][1024-1:0]oc_mem2;
	bit [bucket_num*2-1:0][1024-1:0]oc_mem3;
	integer data_file0,data_file1,data_file2,data_file3;
	integer i;

	integer fd;
	
	initial begin
		fd = $fopen("/home/amax/cj/chisel_common/sw/data_generate/data/output", "w");
		$display("fd = %x\n",fd);
		
		data_file0 = $fopen("/home/amax/cj/chisel_common/sw/data_generate/data/oc_mem0.txt", "r");
		data_file1 = $fopen("/home/amax/cj/chisel_common/sw/data_generate/data/oc_mem1.txt", "r");
		data_file2 = $fopen("/home/amax/cj/chisel_common/sw/data_generate/data/oc_mem2.txt", "r");
		data_file3 = $fopen("/home/amax/cj/chisel_common/sw/data_generate/data/oc_mem3.txt", "r");

		
		reset <= 1;
		clock = 1;
		#1000;
		reset <= 0;
		#100;
		out_io_res_error_0.start();
		out_io_res_error_1.start();
		out_io_res_error_2.start();
		out_io_res_error_3.start();
		out_io_res_failed_0.start();
		out_io_res_failed_1.start();
		out_io_res_failed_2.start();
		out_io_res_failed_3.start();
		out_io_res_success_0.start();
		out_io_res_success_1.start();
		out_io_res_success_2.start();
		out_io_res_success_3.start();
		hbm0.init_from_file("/home/amax/cj/chisel_common/sw/data_generate/data/hbm0.txt");
		hbm1.init_from_file("/home/amax/cj/chisel_common/sw/data_generate/data/hbm1.txt");
		hbm2.init_from_file("/home/amax/cj/chisel_common/sw/data_generate/data/hbm2.txt");
		hbm3.init_from_file("/home/amax/cj/chisel_common/sw/data_generate/data/hbm3.txt");
		#10;
		if (data_file0 == 0 || data_file1 == 0 || data_file2 == 0 || data_file3 == 0) begin
			$display("data_file handle was NULL");
			// $finish;
		end
		else begin
			for(i=0;i<bucket_num*chain_len;i++)begin
				$fscanf(data_file0,"%x" ,oc_mem0[i]) ;
				$fscanf(data_file1,"%x" ,oc_mem1[i]) ;
				$fscanf(data_file2,"%x" ,oc_mem2[i]) ;
				$fscanf(data_file3,"%x" ,oc_mem3[i]) ;
			end
		end

		

		io_inits_init_en_0		<=1;
		io_inits_init_en_1		<=1;
		io_inits_init_en_2		<=1;
		io_inits_init_en_3		<=1;

		for(i=0;i<bucket_num*chain_len;i++)begin
			io_inits_addr_a_0		<= i;
			io_inits_addr_a_1		<= i;
			io_inits_addr_a_2		<= i;
			io_inits_addr_a_3		<= i;
			io_inits_wr_en_a_0		<= 1;
			io_inits_wr_en_a_1		<= 1;
			io_inits_wr_en_a_2		<= 1;
			io_inits_wr_en_a_3		<= 1;
			io_inits_data_in_a_0	<= oc_mem0[i];
			io_inits_data_in_a_1	<= oc_mem1[i];
			io_inits_data_in_a_2	<= oc_mem2[i];
			io_inits_data_in_a_3	<= oc_mem3[i];
			#10;
		end
		io_inits_init_en_0		<= 0;
		io_inits_init_en_1		<= 0;
		io_inits_init_en_2		<= 0;
		io_inits_init_en_3		<= 0;

		#50;
		//key, addr, lock, is_unlock, tb_idx, len, last 
		in_io_req.init_from_file("/home/amax/cj/chisel_common/sw/data_generate/data/reqs.txt");
	end

    always #5 clock=~clock;
endmodule

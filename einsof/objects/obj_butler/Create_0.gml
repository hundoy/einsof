/// @description Insert description here
// You can write your code in this editor

// global constant 
global.sw = camera_get_view_width(view_camera[0]);
global.sh = camera_get_view_height(view_camera[0]);
// colors
global.col_name = $8ffffb;
global.col_text = $fcffec;

// instance
interact_ins = noone;
ins_player = noone;
ins_msgbox = noone;
ins_lh = noone;
ins_sel = noone;

// control
is_process_script = false;
script_content = "";
script_list = ds_list_create();
script_tag_map = ds_map_create();
script_i = -100;
cond_has_found_list = ds_list_create(); // whether has found the right condition
is_cond_skip = false;
skiping_cond_level = 0;
go_script_i = -100;
sel_list = ds_list_create();

// text control
txt_max_line = 2;
txt_line_list = ds_list_create();
txt_start_li = -1;
txt_li = -1;
txt_i = -1;
txt_step_cnt = 4; // the step count for one word
txt_step_i = -1; // add 1 per step. When it reach txt_step_cnt, print next word.
is_intext = false;
is_pageend = false;

script_val_map = ds_map_create();
script_str_map = ds_map_create();
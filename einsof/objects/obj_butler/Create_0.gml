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
ins_sel = noone;

// surface
surf_adv = noone;

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

// bg control
bg_name = "";
is_show_bg = false;
bg_name_list = ds_list_create();
ds_list_add(bg_name_list, "7home");
ds_list_add(bg_name_list, "xiang");
ds_list_add(bg_name_list, "cafe");
ds_list_add(bg_name_list, "bath");
ds_list_add(bg_name_list, "hotel");
ds_list_add(bg_name_list, "rest");

// lh control
lh_data = ds_map_create();
var spids = [sp_lh_boy, sp_lh_wolf, sp_lh_girl];
for (var i=0; i<array_length_1d(spids); i++){
	var spid = spids[i];
	var spname = sprite_get_name(spid);
	ds_map_add(lh_data, string_replace(spname, "sp_lh_", ""), spid);
}
lh_name = "";

// trans control
trans_sp = noone;
// 0- no trans  1- prepare trans, get the sp. 2- in traning
trans_period = 0; 
trans_i = -1;
trans_tar = -1;

// text control
txt_max_line = 2;
txt_line_list = ds_list_create();
txt_start_li = -1;
txt_li = -1;
txt_i = -1;
txt_step_cnt = 5; // the step count for one word
txt_step_i = -1; // add 1 per step. When it reach txt_step_cnt, print next word.
is_intext = false;
is_pageend = false;
is_skip = false;
is_skippage = false;

script_val_map = ds_map_create();
script_str_map = ds_map_create();
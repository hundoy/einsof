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

// bg control, define frame index to a bg name
bg_name = "";
is_show_bg = false;
bg_name_list = ds_list_create();
var bg_name_arr = ["7home", "xiang", "cafe", "bath", "hotel", "rest"];
for (var i=0; i<array_length_1d(bg_name_arr); i++){
    ds_list_add(bg_name_list, bg_name_arr[i]);
}

// lh control
lh_data_map = ds_map_create();
lh_gname_gid_map = ds_map_create();
lh_face_rect_map = ds_map_create();
var sp_lh_arr = [sp_lh_java_g1_normal, sp_lh_java_g1_cap, sp_lh_java_g2_think];
var sp_lh_face_arr = [sp_lh_java_f_g1, sp_lh_java_f_g2]
lh_face_rect_map[? "java_f_g1"] = [312,106];
lh_face_rect_map[? "java_f_g2"] = [264,100];

for (var i=0; i<array_length_1d(sp_lh_arr); i++){
	var spid = sp_lh_arr[i];
	var spname = sprite_get_name(spid);
	ds_map_add(lh_data_map, string_replace(spname, "sp_lh_", ""), spid);
    
    var arr = string_split("_", spname, true);
    ds_map_add(lh_gname_gid_map, arr[4], arr[3]);
}
for (var i=0; i<array_length_1d(sp_lh_face_arr); i++){
	var spid = sp_lh_face_arr[i];
	var spname = sprite_get_name(spid);
    spname = string_replace(spname, "sp_lh_", "");
	ds_map_add(lh_data_map, spname, spid);
    var face_rect = lh_face_rect_map[? spname];
    
    face_rect[0] = face_rect[0]-global.sw/4;
    face_rect[1] = face_rect[1];
    lh_face_rect_map[? spname] = face_rect;
}
// a map store current display lh data. key: lh_name  value:list( map{pos,c,g,f} )
cur_lh_map = ds_map_create();



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
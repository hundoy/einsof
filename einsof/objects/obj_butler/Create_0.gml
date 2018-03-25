/// @description Insert description here
// You can write your code in this editor

// global constant 
global.sw = camera_get_view_width(view_camera[0]);
global.sh = camera_get_view_height(view_camera[0]);

// instance
interact_ins = noone;
ins_player = noone;
ins_msgbox = noone;
ins_lh = noone;

// control
is_process_script = false;
script_content = "";
script_list = ds_list_create();
script_i = -100;

script_val_map = ds_map_create();
script_str_map = ds_map_create();
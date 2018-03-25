/// @description Insert description here
// You can write your code in this editor

// lh prepare
lh_data = ds_map_create();
var spids = [sp_lh_boy, sp_lh_wolf, sp_lh_girl];
for (var i=0; i<array_length_1d(spids); i++){
	var spid = spids[i];
	var spname = sprite_get_name(spid);
	ds_map_add(lh_data, string_replace(spname, "sp_lh_", ""), spid);
}

// control
say_lh_name = "";
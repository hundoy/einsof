///@param param_map
///@param lhdata
///@param key_name
///@param default_val

var param_map = argument0;
var lhdata = argument1;
var key_name = argument2;
var default_val = argument3;


var rs = ds_map_exists(param_map, key_name) ? param_map[? key_name] : (ds_map_exists(lhdata, key_name) ? lhdata[? key_name] : default_val);
return rs;
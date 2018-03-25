///@param script_line_map
var param_map = argument0;

var type = param_map[? "type"];
var rs = ds_map_create();
var go_next = true;

switch(type){
    case "lh":
        var n = param_map[? "name"];
        ins_lh.say_lh_name = n;
        break;
    case "dh":
        var n = param_map[? "name"];
        ins_msgbox.say_name = n;
        ins_msgbox.is_show = true;
        break;
    case "xlh":
        ins_lh.say_lh_name = "";
        break;
    case "xdh":
        ins_msgbox.say_name = "";
        ins_msgbox.is_show = false;
        break;
    case "str":
        var k = ds_map_find_first(param_map);
        if (k=="type") k = ds_map_find_next(param_map, k);
        var v = ds_map_find_value(param_map, k);
        
        if (ds_map_exists(script_str_map, k)) ds_map_delete(script_str_map, k);
        script_str_map[? k] = v;
        break;
    case "val":
        var k = ds_map_find_first(param_map);
        if (k=="type") k = ds_map_find_next(param_map, k);
        var v = ds_map_find_value(param_map, k);
        
        if (!ds_map_exists(script_val_map, k)) ds_map_add(script_val_map, k, 0);
        var rs = ds_map_find_value(script_val_map, k);
        
        
        script_val_map[? k] = v;
        break;
    default:
        // text
        var text = param_map[? "text"];
        ins_msgbox.say_text = text;
        go_next = false;
        break;
}

ds_map_add(rs, "go_next", go_next);

return rs;

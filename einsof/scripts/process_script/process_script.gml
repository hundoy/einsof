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
        var rs = calculate_variable(k, v);

        script_val_map[? k] = rs;
        break;
    default:
        // text
        var text = param_map[? "text"];
        // replace val and str
        while(string_pos("\\s", text)){
            var si = string_pos("\\s",text);
            var ei = string_pos("]",text);
            var val_k = string_copy(text, si+3, ei-si-3);
            var val_v = script_str_map[? val_k];
            var ori_str = string_copy(text, si, ei-si+1);
            text = string_replace_all(text, ori_str, val_v);
        }
        while(string_pos("\\v", text)){
            var si = string_pos("\\v",text);
            var ei = string_pos("]",text);
            var val_k = string_copy(text, si+3, ei-si-3);
            var val_v = script_val_map[? val_k];
            var ori_str = string_copy(text, si, ei-si+1);
            text = string_replace_all(text, ori_str, string(val_v));
        }
        
        ins_msgbox.say_text = text;
        go_next = false;
        break;
}

ds_map_add(rs, "go_next", go_next);

return rs;

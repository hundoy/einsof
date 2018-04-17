///@param script_line_map
///@param next_script_line_map. When there is no next script, this is noone
var param_map = argument0;
var next_param_map = argument1;

var type = param_map[? "type"];
var scriptrs = ds_map_create();
var go_next = true;

// check cond param in common command. skip cond-false command. 
if(ds_map_exists(param_map, "cond") && type!="if" && type!="elsif"){
    var cmdcond = ds_map_find_value(param_map, "cond");
    var cmdcond_rs = check_cond(cmdcond);
    if (!cmdcond_rs){
        ds_map_add(scriptrs, "go_next", go_next);
        return scriptrs;
    }
}

switch(type){
    case "lh":
        if (ds_map_exists(param_map, "t")){
            // actually, this is frame, not time.
            var trans_time = real(param_map[? "t"]);
            trans_period = 1;
            trans_tar = trans_time;
        }
        
        var n = param_map[? "name"];
        var pos = param_map[? "p"];
        var g = param_map[? "g"];
        var c = param_map[? "c"];
        var f = param_map[? "f"];
        var lhdata = ds_map_create();
        lhdata[? "pos"] = pos;
        lhdata[? "g"] = g;
        lhdata[? "c"] = c;
        lhdata[? "f"] = f;
        
        if (!ds_map_exists(cur_lh_map, n)){
            var newlist = ds_list_create();
            ds_map_add_list(cur_lh_map, n, newlist);
        }
        var lhdata_list = cur_lh_map[? n]
        
        lhdata_list[| 0] = lhdata;
        ds_list_mark_as_map(lhdata_list, 0);
        ds_map_add_list(cur_lh_map, n, lhdata_list);
        break;
    case "dh":
        var n = param_map[? "name"];
        ins_msgbox.say_name = n;
        ins_msgbox.is_show = true;
        break;
    case "xlh":
        if (!ds_map_exists(param_map, "n")){
            // destroy all lh
            ds_map_clear(cur_lh_map);
        } else {
            var n = param_map[? "name"];
            // destroy one lh
            // ...
        }
        break;
    case "xdh":
        ins_msgbox.say_name = "";
        ins_msgbox.say_text = "";
        ins_msgbox.is_show = false;
        break;
    case "bg":
        if (ds_map_exists(param_map, "t")){
            // actually, this is frame, not time.
            var trans_time = real(param_map[? "t"]);
            trans_period = 1;
            trans_tar = trans_time;
        }
    
        if (ds_map_exists(param_map, "name")){
            is_show_bg = true;
            bg_name = param_map[? "name"];
        } else {
            bg_name = "";
            is_show_bg = false;
        }
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
    case "if":
    case "elsif":
        var cond = param_map[? "cond"];
        var rs = check_cond(cond); // return true/false
        if (type=="if"){
            // when if, init cond_has_found. cond_skip based on rs directly.
            ds_list_add(cond_has_found_list, rs); 
            ds_map_add(scriptrs, "cond_skip", !rs);
        } else {
            // when elsif, cond_skip based on cond_has_found and rs.
            var cond_has_found = cond_has_found_list[| ds_list_size(cond_has_found_list)-1]; 
            ds_map_add(scriptrs, "cond_skip", cond_has_found || !rs);
            if (rs) cond_has_found_list[| ds_list_size(cond_has_found_list)-1] = true;
        }
        break;
    case "else":
        var cond_has_found = cond_has_found_list[| ds_list_size(cond_has_found_list)-1];
        ds_map_add(scriptrs, "cond_skip", cond_has_found);
        break;
    case "endif":
        ds_list_delete(cond_has_found_list, ds_list_size(cond_has_found_list)-1);
        ds_map_add(scriptrs, "cond_skip", false);
        break;
    case "tag":
        // do nothing
        break;
    case "jump":
        var jump_tag = param_map[? "name"];
        if (ds_map_exists(script_tag_map, jump_tag)){
            var jump_i = script_tag_map[? jump_tag];
            ds_map_add(scriptrs, "go_script_i", jump_i);
        } else{
            show_debug_message("[SCRIPT ERROR] There is no tag "+jump_tag);
        }
        break;
    case "sel":
        // all the sel commands are processed here.
        // type: clear/add/rm/show
        var sel_type = param_map[? "name"];
        switch(sel_type){
            case "clear":
                ds_list_clear(sel_list);
                break;
            case "add":
                var sel_tag = param_map[? "t"];
                var sel_text = param_map[? "x"];
                ds_list_add(sel_list, [sel_tag, sel_text]);
                break;
            case "rm":
                // two ways to remove a sel. By tag_name or by index.
                if (ds_map_exists(param_map, "t")){
                    var sel_tag = param_map[? "t"];
                    for (var sel_i=0;sel_i<ds_list_size(sel_list);sel_i+=1){
                        var tuple = sel_list[| sel_i];
                        if (sel_tag==tuple[0]) ds_list_delete(sel_list, sel_i);
                    }
                }
                if (ds_map_exists(param_map, "i")){
                    var sel_i = param_map[? "i"];
                    if (sel_i<=ds_list_size(sel_list)-1) ds_list_delete(sel_list, sel_i);
                }
                break;
            case "show":
                ins_sel.sel_list = sel_list;
                ins_sel.is_sel = true;
                go_next = false;
                break;
        }
        break;
    default:
        // text
        var text = param_map[? "text"];
        process_text(text);
        // read script until a non-text script
        go_next = (next_param_map!=noone && next_param_map[? "type"]=="text");
        break;
}

ds_map_add(scriptrs, "go_next", go_next);

return scriptrs;

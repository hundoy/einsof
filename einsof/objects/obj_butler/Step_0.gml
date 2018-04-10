/// @description Insert description here
// You can write your code in this editor

if (ins_player == noone){
    ins_player = instance_find(obj_walk_boy, 0);
}
if (ins_msgbox == noone){
    ins_msgbox = instance_find(obj_msgbox, 0);
}
if (ins_lh == noone){
    ins_lh = instance_find(obj_lh, 0);
}
if (ins_sel == noone){
    ins_sel = instance_find(obj_sel, 0);
}

var is_load_end = ins_player!=noone && ins_msgbox!=noone && ins_lh!=noone && ins_sel!=noone;

// press skip button
var is_press_skip = keyboard_check(vk_control);

// process text
if (is_load_end && is_intext){
    // limit process
    if (!is_pageend && txt_step_i>=txt_step_cnt){
        txt_i+=1;
        // reach a line
        if (txt_i>string_length(txt_line_list[| txt_li])){
            txt_i = 0;
            txt_li += 1;
            
            // reach a page. reach max line or there is no line
            if (txt_li-txt_start_li>=txt_max_line || txt_li>=ds_list_size(txt_line_list)){
                txt_li -= 1;
                is_pageend = true;
                ins_msgbox.is_waitclick = true;
            }
        }
        
        txt_step_i = 0;
    }
    
    if (is_skippage || is_press_skip){
        txt_li = min(txt_start_li + txt_max_line - 1, ds_list_size(txt_line_list) - 1);
        txt_i = string_length(txt_line_list[| txt_li]);
        is_pageend = true;
        ins_msgbox.is_waitclick = true;
        is_skippage = false;
    }
    
    // get text
    var text = "";
    if (is_pageend){
        for (var i=txt_start_li; i<txt_li+1; i+=1){
            text += txt_line_list[| i]+"\n";
        }
    } else {
        for (var i=txt_start_li; i<txt_li; i+=1){
            text += txt_line_list[| i]+"\n";
        }
        text += string_copy(txt_line_list[| txt_li], 0, txt_i+1);
    }
    ins_msgbox.say_text = text;
    
    // others
    if (!is_pageend) txt_step_i+=1;
}



// press keyboard direction key
key_y = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
if (is_load_end && key_y!=0){
    if (ins_sel.is_sel){
        var sel_cnt = ds_list_size(sel_list);
        var sel_i = ins_sel.sel_i + key_y;
        if (sel_i>sel_cnt-1) sel_i = 0;
        if (sel_i<0) sel_i = sel_cnt-1;
        ins_sel.sel_i = sel_i;
    }
}

// press space and trigger interact
var is_press_enter = keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left);
if (is_load_end && (is_press_enter || is_press_skip)){
    // HANG when in sel
    if (ins_sel.is_sel){
        if (ins_sel.sel_i<0 || !is_press_enter) return;
        
        // click a sel option
        var sel_data = sel_list[| ins_sel.sel_i];
        var jump_tag = sel_data[0];
        ins_sel.is_sel = false;
        ins_sel.sel_i = -1;

        if (ds_map_exists(script_tag_map, jump_tag)){
            go_script_i = script_tag_map[? jump_tag];
        }
    }
    
    // skip if not press enter
    if (!is_process_script && is_press_enter){
        // when map control
        if (interact_ins!=noone){
            // init script
            ins_player.is_movable = false;
            script_content = interact_ins.script_content;
            var script_load_rs = load_script(script_content);
            script_list = script_load_rs[? "script_list"];
            script_tag_map = script_load_rs[? "tag_map"];
            script_i = -1;
            is_process_script = true;
        }
    }
    
    // process script
    if (is_process_script){
        // text wait click process
        if (is_intext){
            if (is_pageend){
                txt_li += 1;
                
                if (txt_li>=ds_list_size(txt_line_list)){
                    is_intext = false;
                    is_pageend = false;
                    ins_msgbox.is_waitclick = false;
                    ds_list_clear(txt_line_list);
                    txt_li = -1;
                    txt_i = -1;
                    txt_step_i = -1;
                } else {
                    txt_start_li = txt_li;
                    txt_i = 0;
                    is_pageend = false;
                    ins_msgbox.is_waitclick = false;
                    return;
                }           
            } else {
                is_skippage = true;
                return;
            }
        }
        
        var is_script_end = false;
        if (script_i >= ds_list_size(script_list)-1){
            // script end
            is_script_end = true;
        } else{
            // process script
            var go_next = true;
            do{
                // must do
                // script_i change firstly. If there is go target, change to target. or +1
                if (go_script_i>=0){
                    script_i = go_script_i;
                    go_script_i = -100;
                } else {
                    script_i+=1;
                }
                is_script_end = (script_i >= ds_list_size(script_list)-1);
                var params = script_list[| script_i];
                
                // skip cond-false block
                var cmdtype = params[? "type"];
                if (is_cond_skip && cmdtype=="if"){
                    skiping_cond_level+=1;
                }
                if (is_cond_skip && skiping_cond_level>0){
                    if (cmdtype=="endif") skiping_cond_level-=1;
                    continue;
                }
                if (is_cond_skip && cmdtype!="elsif" && cmdtype!="else" && cmdtype!="endif") continue;
                
                // process script
                var rs = noone;
                if (script_i<ds_list_size(script_list)-1){
                    var next_params = script_list[| script_i+1];
                    rs = process_script(params, next_params);
                } else {
                    rs = process_script(params, noone);
                }
                
                // process result
                go_next = rs[? "go_next"];
                if (ds_map_exists(rs, "cond_skip")) is_cond_skip = rs[? "cond_skip"];
                if (ds_map_exists(rs, "go_script_i")){
                    go_script_i = rs[? "go_script_i"];
                    is_script_end = false;
                }
            } until(!go_next || is_script_end)
        }
        
        if (is_script_end){
            ins_player.is_movable = true;
            script_content = "";
            ds_list_clear(script_list);
            script_i = -100;
            is_process_script = false;
        }
    }
}
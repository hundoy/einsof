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

var is_load_end = ins_player!=noone && ins_msgbox!=noone && ins_lh!=noone;

// press space and trigger interact
if is_load_end && keyboard_check_pressed(vk_space){
    if (!is_process_script){
        // when map control
        if (interact_ins!=noone){
            // init script
            ins_player.is_movable = false;
            script_content = interact_ins.script_content;
            script_list = load_script(script_content);
            script_i = -1;
            is_process_script = true;
        }
    }
    
    // process script
    if (is_process_script){
        var is_script_end = false;
        if (script_i >= ds_list_size(script_list)-1){
            // script end
            is_script_end = true;
        } else{
            // process script
            var go_next = true;
            do{
                script_i+=1;
                var params = script_list[| script_i];
                var rs = process_script(params);
                go_next = rs[? "go_next"];
                is_script_end = (script_i >= ds_list_size(script_list)-1);
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
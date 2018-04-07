///@param script_text
var text = argument0;

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


// set text to noone line.
// if it reach line width limit, cut it to a list
var i = 1;
var start_i = 1;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font_sy);
while(i<=string_length(text)){
    var word = string_char_at(text, i);
    var cur_line = string_copy(text,start_i,i-start_i+1);
    var cur_line_w = string_width(cur_line);
    if (cur_line_w>ins_msgbox.boxWidth){
        // [start_i, i] is more than limit, get [start_i, i-1]. start_i=i, i=i
        ds_list_add(txt_line_list, string_copy(text,start_i,i-start_i));
        start_i = i;
    } else {
        i+=1;
    }
}
// add rest
if (i>=start_i){
    ds_list_add(txt_line_list, string_copy(text,start_i,i-start_i));
}

txt_start_li = 0;
txt_li = 0;
txt_i = 0;
txt_step_i = 0;
is_intext = true;





/// @description Insert description here
// You can write your code in this editor

if (!is_sel || ds_list_empty(sel_list)) return;

// draw bg
draw_sprite(sp_selbg, 0, 0, 0);
// draw sel bg and text
var sel_cnt = ds_list_size(sel_list);
var sel_spacing = 80;
var mid_i = (sel_cnt-1)/2;
var sb_x = global.sw div 2;
var sb_y = global.sh div 2;

draw_set_font(font_sy18);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for (var i=0; i<sel_cnt; i+=1){
    var bg_spi = 0;
    var text_col = global.col_text;
    if (i==sel_i){
        bg_spi = 1;
        text_col = global.col_name;
    }
    var sel_data = sel_list[| i];
    draw_sprite_ext(sp_sel, bg_spi, sb_x, sb_y + (i-mid_i)*sel_spacing, 1, 1, 0, c_white, 0.7);
    draw_set_color(text_col);
    draw_text(sb_x,sb_y + (i-mid_i)*sel_spacing,sel_data[1]);
}

// mouse 

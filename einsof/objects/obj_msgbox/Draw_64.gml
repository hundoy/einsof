/// @description Insert description here
// You can write your code in this editor

if (!is_show){
    return;
}

var cur_msg_data = msg_data[| msg_i];
var text = cur_msg_data[? "text"];
var msg_name = cur_msg_data[? "name"];
var lh_name = cur_msg_data[? "lh"];

text = say_text;
msg_name = say_name;

// draw message background
draw_sprite_ext(sp_msgbg, 0, msgbox_x, msgbox_y, 1, 1, 0, c_white, 0.9);
//draw_sprite(sp_circle, 0, 0, 0);
//draw_sprite(sp_circle2, 0, msgbox_x, msgbox_y);
//draw_sprite(sp_circle2, 0, msgbox_x+name_margin_x, msgbox_y+name_margin_y);

// draw text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font_sy18);
//draw_set_font(font_sans);
draw_set_color(global.col_name);
draw_text(msgbox_x+name_margin_x, msgbox_y+name_margin_y, msg_name);
//draw_text(msgbox_x, msgbox_y, "刘大拿");

draw_set_font(font_sy);
draw_set_color(global.col_text);
//draw_text_ext(msgbox_x+text_margin_x, msgbox_y+text_margin_y, text, stringHeight, boxWidth);
//draw_text_outline(msgbox_x+text_margin_x, msgbox_y+text_margin_y, text, 2, c_red, 8);
//draw_text_outline(msgbox_x+text_margin_x, msgbox_y+text_margin_y, "This is English, and is's look better", 2, c_red, 8);
var tol=2;
for(var dto_i=45; dto_i<405; dto_i+=360/8)
{
    //draw_text(argument0+lengthdir_x(argument3,dto_i),argument1+lengthdir_y(argument3,dto_i),string_hash_to_newline(argument2));
    draw_text_ext_transformed_colour(msgbox_x+text_margin_x+lengthdir_x(tol,dto_i), msgbox_y+text_margin_y+lengthdir_y(tol,dto_i), text, stringHeight, boxWidth, 1.0, 1.0, 0, c_black, c_black, c_black, c_black, 1);
}

draw_text_ext_transformed_colour(msgbox_x+text_margin_x, msgbox_y+text_margin_y, text, stringHeight, boxWidth, 1.0, 1.0, 0, c_white, c_white, c_white, c_white, 1);

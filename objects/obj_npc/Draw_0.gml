/// @description Insert description here
// You can write your code in this editor
draw_self();

if (is_interact_valid){
    icon_index += 1;
    icon_index %= 1000;
    //show_debug_message(string(sp_icon_talk.image_number));
    var subimg = icon_index / 20 % sprite_get_number(sp_icon_talk);
    draw_sprite(sp_icon_talk, subimg, x, y-32);
}
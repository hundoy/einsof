/// @description Insert description here
// You can write your code in this editor

if (surface_exists(surf_adv)){
    draw_surface(surf_adv, 0, 0);
}

if (trans_period==2){
    var cur_alpha = 1 - trans_i/trans_tar;
    draw_sprite_ext(trans_sp, 0, 0, 0, 1.0, 1.0, 0, c_white, cur_alpha);
    trans_i+=1;
    
    if (trans_i>trans_tar){
        trans_i = -1;
        trans_tar = -1;
        sprite_delete(trans_sp);
        trans_period = 0;
    }
}   

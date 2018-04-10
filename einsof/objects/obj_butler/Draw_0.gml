/// @description Insert description here
// You can write your code in this editor

// trans process
if (trans_period==1){
    // prepare
    if (trans_sp!=noone) sprite_delete(trans_sp);
    
    trans_sp = sprite_create_from_surface(surf_adv, 0, 0, global.sw, global.sh, false, false, 0, 0);
    trans_i = 0;
    if (trans_tar==-1) trans_tar = 60;
    trans_period=2;
}

// paint
if (true){
    // surface prepare
    if !surface_exists(surf_adv){
        surf_adv = surface_create(global.sw, global.sh);
    }
    surface_set_target(surf_adv);
    draw_clear_alpha(c_black, 0);
    
    // bg
    var spid = ds_list_find_index(bg_name_list, bg_name);
    if (spid>=0){
        draw_sprite(sp_bg, spid, global.sw/2, global.sh/2);
    }
    
    // lh
    if (lh_name!=""){
        var lh_spid = lh_data[? lh_name];
        draw_sprite(lh_spid, 0, global.sw div 4, global.sh);
    }
    
    // end draw surface
    surface_reset_target();
}


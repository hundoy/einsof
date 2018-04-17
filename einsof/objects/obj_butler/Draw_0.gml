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
    if (ds_map_size(cur_lh_map)>0){
        var size = ds_map_size(cur_lh_map) ;
        var lh_name = ds_map_find_first(cur_lh_map);
        for (var i = 0; i < size; i++;){
            var lhdata_list = cur_lh_map[? lh_name];
            var lhdata = lhdata_list[| 0];
            var pos = lhdata[? "pos"];
            switch(pos){
                case "l":
                    pos = 0.25;
                    break;
                case "r":
                    pos = 0.75;
                    break;
                default:
                    pos = real(pos);
            }
            var g = lhdata[? "g"];
            var c = lhdata[? "c"];
            var f = lhdata[? "f"];
            // java_g1_normal
            var key = lh_name + "_" + lh_gname_gid_map[? g] + "_" + g;
            var lh_spid = lh_data_map[? key];
            // java_f_g1
            var key_face = lh_name + "_f_" + lh_gname_gid_map[? g];
            var lh_face_spid = lh_data_map[? key_face];
            var face_rect = lh_face_rect_map[? key_face];
            
            // paint
            draw_sprite(lh_spid, c, global.sw * pos, global.sh);
            draw_sprite(lh_face_spid, f, global.sw * pos + face_rect[0], face_rect[1]);
            
            lh_name = ds_map_find_next(cur_lh_map, lh_name);
        }
    }
    
    // end draw surface
    surface_reset_target();
}


if (trans_sp!=noone) sprite_delete(trans_sp);
//surface_copy(surf_adv, 0, 0, application_surface);
trans_sp = sprite_create_from_surface(surf_adv, 0, 0, global.sw, global.sh, false, false, 0, 0);
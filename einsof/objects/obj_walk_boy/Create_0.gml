/// @description Insert description here
// You can write your code in this editor
image_speed = 1;
image_index = 1;
walk_dir = 4;
is_moving = false;
walk_speed = 4;


wall_tid = layer_tilemap_get_id(layer_get_id("til_wall"));
wall_size = tilemap_get_tile_width(wall_tid);

// control
is_movable = true;
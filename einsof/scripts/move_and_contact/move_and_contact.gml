///@param tilemap_id
///@param tile_size
///@param velocity_array
var tilemap_id = argument0;
var tile_size = argument1;
var velocity = argument2;

var ori_x = x;
var ori_y = y;

x += velocity[0];

// tileset collide check
if velocity[0] > 0 {
	var found_tile_right = tile_collide_at_points(tilemap_id, [bbox_right-1, bbox_top], [bbox_right-1, bbox_bottom-1]);
	if found_tile_right{
		x = bbox_right div tile_size * tile_size - (bbox_right - x);
		//velocity[@ 0] = 0;
	}
}
if velocity[0] < 0 {
	var found_tile_left = tile_collide_at_points(tilemap_id, [bbox_left, bbox_top], [bbox_left, bbox_bottom-1]);
	if found_tile_left{
		x = (bbox_left div tile_size + 1)*tile_size + (x - bbox_left);
		//velocity[@ 0] = 0;
	}
}

// object collide check
if (velocity[0]!=0){
	with(obj_npc){
		if (place_meeting(x,y,other)){
			if velocity[0] > 0 {
				other.x -= other.bbox_right - bbox_left + 1;
			}
			if velocity[0] < 0 {
				other.x += bbox_right - other.bbox_left + 1;
			}
		}
	}
}

y += velocity[1];
if velocity[1] > 0 {
	var found_tile_down = tile_collide_at_points(tilemap_id, [bbox_left, bbox_bottom-1], [bbox_right-1, bbox_bottom-1]);
	if found_tile_down{
		y = bbox_bottom div tile_size * tile_size - (bbox_bottom - y);
		//velocity[@ 1] = 0;
	}
}

if velocity[1] < 0 {
	var found_tile_up = tile_collide_at_points(tilemap_id, [bbox_left, bbox_top], [bbox_right-1, bbox_top]);
	if found_tile_up{
		y = (bbox_top div tile_size + 1)*tile_size + (y - bbox_top);
		//velocity[@ 1] = 0;
	}
}

// object collide check
if (velocity[1]!=0){
	with(obj_npc){
		if (place_meeting(x,y,other)){
			if velocity[1] > 0 {
				other.y -= other.bbox_bottom - bbox_top + 1;
			}
			if velocity[1] < 0 {
				other.y += bbox_bottom - other.bbox_top + 1;
			} 
		}
	}
}



// position fix, avoid position jumping.
var x_move = x - ori_x;
var y_move = y - ori_y;
//if (x_move*velocity[0]<0 || abs(velocity[0]) < abs(x_move)){
//	x_move = 0;
//}
//if (y_move*velocity[1]<0 || abs(velocity[1]) < abs(y_move)){
//	y_move = 0;
//}
velocity[@ 0] = x_move;
velocity[@ 1] = y_move;

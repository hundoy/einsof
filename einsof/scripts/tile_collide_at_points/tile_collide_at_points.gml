///@param tilemap_id
///@param point_arrays...
var tilemap_id = argument[0];
var found = false;
for (var i=1; i<argument_count; i++){
	var point = argument[i];
	if (tilemap_get_at_pixel(tilemap_id, point[0], point[1])){
		found = true;
		break;
	}
}

return found;
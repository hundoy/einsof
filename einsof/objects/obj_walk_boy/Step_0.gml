/// @description Insert description here
// You can write your code in this editor

if (!is_movable){
    image_index = image_index % 3 + 12 * (walk_dir/2-1);
    image_speed = 0;
    return;
}

// set velocity
var x_move = (keyboard_check(vk_right) - keyboard_check(vk_left)) * walk_speed
var y_move = (keyboard_check(vk_down) - keyboard_check(vk_up)) * walk_speed
var move_velocity = [x_move, y_move];

// collide check with tile/object and fix velocity
move_and_contact(wall_tid, wall_size, move_velocity);

// interact check
var min_ins_dis = 1000;
var interact_ins = noone;
with(obj_npc){
    self.is_interact_valid = false;
    var ins_dis = distance_to_object(other);
    if (ins_dis<min_ins_dis && ins_dis<=self.interact_r){
        min_ins_dis = ins_dis;
        interact_ins = id;
    }
}

//show_debug_message(interact_ins);
if (interact_ins!=noone){
    interact_ins.is_interact_valid = true;
}

// pass variable to butler
with(obj_butler){
    self.interact_ins = interact_ins;
}

// for walk animation
if keyboard_check(vk_left){
	walk_dir = 4;
}
if keyboard_check(vk_right){
	walk_dir = 6;
}

is_moving = move_velocity[0]!=0 or move_velocity[1]!=0;

image_index = image_index % 3 + 12 * (walk_dir/2-1);
image_speed = is_moving;

// fix depth
if (is_moving){
	fix_depth();
}

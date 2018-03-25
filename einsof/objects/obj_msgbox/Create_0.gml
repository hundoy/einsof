/// @description Insert description here
// You can write your code in this editor

// message script
var msg_data_json = @"
[
{'lh':'boy','name':'赵四','text':'这个就是思源黑体吧？门字能看出来，\n这是第二行的文字，跟第一行相映成趣。看起来如果能不错，那就好了。'}
,{'lh':'wolf','name':'王大拿','text':'这是第二句话，希望也能够正常显示出来。'}
,{'lh':'boy','name':'赵四','text':'然后再说最后一句。\n一切就结束了！'}
]
";
msg_data_json = string_replace_all(msg_data_json, "\r\n", "");

var msg_data_map = json_decode(msg_data_json);
msg_data = ds_map_find_value(msg_data_map, "default");
msg_i = 0;
//text = "this is the first time, 这里有中文i see that man waling in the road and stage. oh my god!"
text_margin_x = 50;
text_margin_y = 85;
name_margin_x = 40;
name_margin_y = 15;
boxWidth = sprite_get_width(sp_msgbg)-text_margin_x;
//boxHeight = 
//boxWidth = 700;
stringHeight = 36;
msgbox_x = (camera_get_view_width(view_camera[0]) - sprite_get_width(sp_msgbg))/2;
msgbox_y = camera_get_view_height(view_camera[0]) - sprite_get_height(sp_msgbg);
//show_debug_message(sprite_get_height(sp_msgbg));

// colors
col_name = $8ffffb;
//col_name = make_color_rgb(251,255,143);
col_text = $fcffec;


// control
is_show = false;
say_text = "default";
say_name = "Tom";

//show_debug_message(string(string_width("这个就是思源黑体吧？门字能看出来，")));
//show_debug_message(string(string_width("这是第二行的文字，跟第一行相映成趣。看起来如果能不错，那就好了。")));
//show_debug_message(string(string_width("三个字")));
//show_debug_message(string(string_width("sgz")));
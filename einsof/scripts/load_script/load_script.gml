///@param script_content
var sc = argument0;

var script_arr = ds_list_create();

var arr = string_split("\r\n", script_content, true);
for (var i=0; i<array_length_1d(arr); i+=1){
    var line = arr[i];
    show_debug_message(string(i)+" - "+line);
    if (string_char_at(line, 1)=="["){
        // command
        var kvcmd = ds_map_create();
        var command = string_copy(line, 2, string_length(line)-2);
        var larr = string_split(" ", command, true);
        var type = larr[0]
        ds_map_add(kvcmd, "type", type);
        if array_length_1d(larr)>1{
            // default key is 'n'
            for (var j=1; j<array_length_1d(larr); j+=1){
                var ei = string_pos("=", larr[j]);
                var k = "name";
                var v = larr[j];
                if (ei!=0){
                    k = string_copy(larr[j], 1, ei-1);
                    v = string_copy(larr[j], ei+1, string_length(larr[j])-ei);
                }
                ds_map_add(kvcmd, k, v);
            }
        }
        ds_list_add(script_arr, kvcmd);
    } else {
        // text
        var kvcmd = ds_map_create();
        ds_map_add(kvcmd, "type", "text");
        ds_map_add(kvcmd, "text", line);
        ds_list_add(script_arr, kvcmd);
    }
}

return script_arr;
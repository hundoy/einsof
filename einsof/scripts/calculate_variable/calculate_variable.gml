///@param val_name
///@param val_exp

var val_n = argument0;
var val_exp = argument1;

var opes = ["+", "-", "*", "/", "%"];
val_exp = "+" + val_exp;

var len = string_length(val_exp);

var min_i = find_min_index_by_arr(val_exp, opes);
var cur_exp_start = 1;
var rs = 0;
while (min_i>0){
    // val_exp = ope+rest_right
    var ope = string_copy(val_exp, 1, 1);
    var rest_right = string_copy(val_exp, 2, string_length(val_exp)-1);
    min_i = find_min_index_by_arr(rest_right, opes);
    
    var cur_exp = rest_right;
    if (min_i>0){
        cur_exp = string_copy(rest_right, 1, min_i-1);
    }
    
    // get current expression value.
    var cur_exp_val = 0;
    if (cur_exp=="$"){
        // this is a variable and name is val_n
        cur_exp_val = ds_map_find_value(script_val_map, val_n);
    } else{
        if (string_pos("$", cur_exp)>0){
            // this is a variable
            var cur_exp_val_n = string_copy(cur_exp, 2, string_length(cur_exp)-1);
            cur_exp_val = ds_map_find_value(script_val_map, cur_exp_val_n);
        } else{
            // this is a real
            cur_exp_val = real(cur_exp);
        }
    }
    
    // caculate with operater
    switch(ope){
        case "+":
            rs += cur_exp_val;
            break;
        case "-":
            rs -= cur_exp_val;
            break;
        case "*":
            rs *= cur_exp_val;
            break;
        case "/":
            rs /= cur_exp_val;
            break;
        case "%":
            rs %= cur_exp_val;
            break;
    }
    
    val_exp = string_copy(rest_right, min_i, string_length(rest_right)-min_i+1);
}

return rs;

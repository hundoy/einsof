///@param str
///@param search_arr

var val_exp = argument0;
var opes = argument1;

var min_i = 0;
for (var i=0; i<array_length_1d(opes); i+=1){
    var ope_i = string_pos(opes[i], val_exp);
    if (ope_i==0) continue;
    
    if (min_i==0){
        if (ope_i>0) min_i = ope_i;
    } else{
        if (ope_i<min_i) min_i = ope_i;
    }
}
return min_i;
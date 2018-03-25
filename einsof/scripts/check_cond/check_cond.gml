///@param condition
var cond = argument0;

// v=,<,>,!=,>=,<=
var opes = ["=","<",">","!=","<=",">="];

var ope_i = 0;
var ope = "";
for (var i=0; i<array_length_1d(opes); i++){
    var cur_ope_i = string_pos(opes[i], cond);
    if (cur_ope_i>0){
        ope_i = cur_ope_i;
        ope = opes[i];
    }
}

if (ope_i>0){
    var lexp = string_copy(cond, 1, ope_i-1);
    var rexp = string_copy(cond, ope_i+1, string_length(cond)-ope_i);
    
    var lval = 0;
    var rval = 0;
    if (string_pos("$", lexp)==1){
        lval = script_val_map[? string_copy(lexp, 2, string_length(lexp)-1)];
    } else {
        lval = real(lexp);
    }
    if (string_pos("$", rexp)==1){
        rval = script_val_map[? string_copy(rexp, 2, string_length(rexp)-1)];
    } else {
        rval = real(rexp);
    }
    
    // check start
    switch(ope){
        case "=":
            return lval==rval;
        case ">":
            return lval>rval;
        case "<":
            return lval<rval;
        case ">=":
            return lval>=rval;
        case "<=":
            return lval<=rval;
        case "!=":
            return lval!=rval;
    }
    
} else{
    show_debug_message("cond is invalid! cond:"+cond);
}

return false;
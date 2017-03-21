function [ R ] = get_r_vanishing( v1,v2,v3, r1,r2,r3 )

    v = [v1,v2,v3];
    r = [r1,r2,r3];
    R = [cross(r, v); r; v];

end


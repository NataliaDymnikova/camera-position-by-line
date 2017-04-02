function [ R ] = get_r_vanishing_with_numbers( v1,v2,v3, r1,r2,r3 )

    v = [v1,v2,v3];
    R2 = cross(v,[r1,r2,r3]);
    R2 = R2 / sqrt(R2*R2');
    R1 = cross(R2,v);
    R1 = R1 / sqrt(R1*R1');
    R = [R1; R2; v];

end


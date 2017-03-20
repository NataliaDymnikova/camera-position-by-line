function [ R ] = get_r_small( r1,r2,r3 )
    R = [1,-r3,r2;
        r3,1,-r1;
        -r2,r1,1];
end
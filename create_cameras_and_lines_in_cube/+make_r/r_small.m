function [ R ] = r_small( )
r1 = rand();
r2 = rand();
r3 = rand();

R = [1,-r3,r2;
    r3,1,-r1;
    -r2,r1,1];

end


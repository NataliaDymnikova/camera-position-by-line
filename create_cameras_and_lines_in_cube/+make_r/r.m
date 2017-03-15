function [ R ] = r( )
    [a,b] = get_a_b();
    [c,d] = get_a_b();
    [f,g] = get_a_b();
    
    R = [a,b,0;-b,a,0;0,0,1] * [c,0,d;0,1,0;-d,0,c] * [1,0,0;0,f,g;0,-g,f];
end

function [a,b] = get_a_b() 
    a = rand();
    b = rand();
    s = sqrt(a^2 + b^2);
    a = a/s;
    b = b/s;
end


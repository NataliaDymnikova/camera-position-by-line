function [ R ] = get_r_known_cs(c, s)

R = [c, s, 0;
    -s, c, 0;
    0, 0, 1];

end


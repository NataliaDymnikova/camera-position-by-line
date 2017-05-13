function [ R ] = get_r_known_cs_diff_r(c, s)

R = [c, 0, s;
     0, 1, 0;
    -s, 0, c];

end


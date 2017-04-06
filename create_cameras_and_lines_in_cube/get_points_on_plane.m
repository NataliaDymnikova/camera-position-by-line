function [s,e] = get_points_on_plane()
    A = randi(100);
    B = randi(100);
    C = randi([A+B, 2*(A+B)],1,1);
    D = randi([-2*(C-A-B), 2*(C-A-B)],1,1);
    sx = rand(1,1) - 2;
    sy = rand(1,1) - 2;
    sz = -(D+A*sx+B*sy)/C;
    s = [sx;sy;sz];
    
    ex = rand(1,1) + 1;
    ey = rand(1,1) + 1;
    ez = -(D+A*ex+B*ey)/C;
    e = [ex;ey;ez]; 
end

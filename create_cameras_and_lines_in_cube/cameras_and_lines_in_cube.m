function [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e ] = cameras_and_lines_in_cube( )

%focal length in pixels
fpix = 1;
%varying noise level
nlevel = [0];
noize = 4;
%number of lines
nlines = 3;

cam1 = [get_random(6,8);get_random(6,8);get_random(6,8)];
cam2 = [get_random(6,8);get_random(6,8);get_random(6,8)];
cam3 = [get_random(6,8);get_random(6,8);get_random(6,8)];

t1 = cam1;
t2 = cam2;
t3 = cam3;

R1 = rodrigues(cam1);
R2 = rodrigues(cam2);
R3 = rodrigues(cam3);

[start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points_in_cube(R1,R2,R3,t1,t2,t3,fpix, nlevel, nlines);

t1 = cam1 - cam2;
t2 = 0;
t3 = cam3 - cam2;

R1 = R1 * R2';
R3 = R3 * R2';
R2 = eye(3);
end

function [ x ] = get_random(min, max)
    sign = (mod(randi(100),2) * 2 - 1);
    x = sign * (min + (max-min) * rand());
end

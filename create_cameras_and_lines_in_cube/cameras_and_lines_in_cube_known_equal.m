function [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e, fpix ] = cameras_and_lines_in_cube_known_equal()

%focal length in pixels
fpix = 1e3;
%varying noise level
nlevel = [0, 1., 2.];
%number of lines
nlines = 3;

nlevel = nlevel / fpix;
fpix = 1;

[R1,t1] = get_r_and_t();
[R2,t2] = get_r_and_t();
t3 = t2 + (t2 - t1);
R3 = R2 * (R1' * R2);

[start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points_in_cube(R1,R2,R3,t1,t2,t3,fpix, nlevel, nlines);

t1 = t1 - t2;
t3 = t3 - t2;
t2 = 0;

R1 = R1 * R2';
R3 = R3 * R2';
R2 = eye(3);
end

function [ x ] = get_random(min, max)
    sign = (mod(randi(100),2) * 2 - 1);
    x = sign * (min + (max-min) * rand());
end

function [R,t] = get_r_and_t() 
    flag = true;
    i = 0;
    while flag
        i = i + 1;

        R = make_r.r();
        temp = R(3,:);
        M = min(6./abs(temp));
        m = max(4./abs(temp));
        if m < M
            k = (m + M) / 2.;
            t = -(temp * k)';
            flag = false;
        end
    end
end

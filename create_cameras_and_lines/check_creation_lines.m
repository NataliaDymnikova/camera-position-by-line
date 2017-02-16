function [ isOk ] = check_creation_lines( )

[R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines();

i = 1;
l1 = get_lines_from_camera(camera1s{i}, camera1e{i});
l2 = get_lines_from_camera(camera2s{i}, camera2e{i});
l3 = get_lines_from_camera (camera3s{i}, camera3e{i});

isOk = abs(cross(R*l3(:,1), R'*l1(:,1))' * l2(:,1)) < 10^-10;
end



function [ isOk ] = check_creation_lines( )

[R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines();
l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
l3 = get_lines_from_camera(camera3s{1}, camera3e{1});

isOk = cross(R'*l3(:,1), R*l1(:,1))' * l2(:,1) == 0;

end



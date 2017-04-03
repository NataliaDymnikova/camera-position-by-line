function [ isOk ] = check_creation_lines_in_cube( )

[ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e, fpix ] = cameras_and_lines_in_cube_small_angle_diff();

i = 1;
l1 = get_lines_from_camera(camera1s{i}/fpix, camera1e{i}/fpix);
l2 = get_lines_from_camera(camera2s{i}/fpix, camera2e{i}/fpix);
l3 = get_lines_from_camera(camera3s{i}/fpix, camera3e{i}/fpix);

isOk = abs(cross(R3'*l3(:,1), R1'*l1(:,1))' * (R2'*l2(:,1))) < 10^-10;

i = 2;
l1 = get_lines_from_camera(camera1s{i}/fpix, camera1e{i}/fpix);
l2 = get_lines_from_camera(camera2s{i}/fpix, camera2e{i}/fpix);
l3 = get_lines_from_camera (camera3s{i}/fpix, camera3e{i}/fpix);

isOk = isOk && abs(cross(R3'*l3(:,1), R1'*l1(:,1))' * (R2'*l2(:,1))) < 10^-10;

i = 3;
l1 = get_lines_from_camera(camera1s{i}/fpix, camera1e{i}/fpix);
l2 = get_lines_from_camera(camera2s{i}/fpix, camera2e{i}/fpix);
l3 = get_lines_from_camera (camera3s{i}/fpix, camera3e{i}/fpix);

isOk = isOk && abs(cross(R3'*l3(:,1), R1'*l1(:,1))' * (R2'*l2(:,1))) < 10^-10;

end



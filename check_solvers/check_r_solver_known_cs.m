function [ R_err, k ] = check_r_solver_known_cs( )

    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines('r_known_cs()');

    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});

    %check l

    [c, s] = solver_get_r_equations_known_cs(l1, l2, l3);

    R_min = eye(3);
    R_err_min = inf;
    k = 0;

    if length(c) == 0
        R_err = Inf;
        return
    end

    %y = sqrt((R(3,2)*R(2,1) - R(3,3)*R(1,1)*R(3,1)) / R(1,3));

    %R = [R(1,1)/y, -R(2,1)/y, 0;
    %    R(2,1)/y, R(1,1)/y, 0;
    %    0, 0, 1];
    
    for i = 1:length(c)
        R_test = get_r_known_cs(c(i), s(i));
        [ R_err, t_err ] = test( R, t1, R_test, t1);
        %disp(strcat(num2str(i), '_', num2str(R_err)));
        if (R_err < R_err_min)
            R_err_min = R_err;
            R_min = R;
            k = i;
        end
    end
    R_err = R_err_min;
end


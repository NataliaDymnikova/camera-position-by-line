function [ R_err ] = check_solver_cube_known_equal_r( )

    [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e ] = cameras_and_lines_in_cube_known_equal();

    R1_x = make_r.r_known(R1);
    R1_yz = R1 * R1_x';
    R2_x = make_r.r_known(R1);
    R2_yz = R2 * R2_x';    
    R3_x = make_r.r_known(R3);
    R3_yz = R3 * R3_x';

    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});

    for i = 1:3
        l1(:,i) = R1_yz' * l1(:,i);
        l2(:,i) = R2_yz' * l2(:,i);
        l3(:,i) = R3_yz' * l3(:,i);
    end

    [c, s] = solver_get_r_equations_known_cs1(l1, l2, l3);

    R_err_min = inf;
   
    if length(c) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(c)
        R_test = get_r_known_cs(c(i), s(i));
        [ R_err, t_err ] = test( R2_x' * R1_x, t1, R_test, t1);
        
        if (R_err < R_err_min)
            R_err_min = R_err;
        end
    end
    
    R_err = R_err_min;
end


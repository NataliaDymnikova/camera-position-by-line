function [ R_err ] = check_solver_cube_known_diff_r( )

    [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e ] = cameras_and_lines_in_cube('r_known');

    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});

    [c1, s1, c2, s2] = solver_get_r_equations_known_cs_diff_r(l1, l2, l3);

    R_err_min = inf;
   
    if length(c1) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(c1)
        R_test1 = get_r_known_cs(c1(i), s1(i));
        R_test2 = get_r_known_cs(c2(i), s2(i));
        [ R_err1, t_err ] = test( R1, t1, R_test1, t1);
        [ R_err2, t_err ] = test( R3, t1, R_test2, t1);
        
        R_err = R_err1 + R_err2;
        
        if (R_err < R_err_min)
            R_err_min = R_err;
        end
    end
    
    R_err = R_err_min;

end
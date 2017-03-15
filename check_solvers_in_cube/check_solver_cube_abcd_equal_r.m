function [ R_err ] = check_solver_cube_abcd_equal_r(  )

    [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e ] = cameras_and_lines_in_cube_small_angle_equal('r_abcd');

    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});

    [a,b,c,d] = solver_get_r_equations_abcd(l1, l2, l3);

    R_err_min = inf;
   
    if length(a) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(a)
        R_test = get_r_abcd(a(i),b(i),c(i),d(i));
        [ R_err, t_err ] = test( R1, t1, R_test, t1);
        
        if (R_err < R_err_min)
            R_err_min = R_err;
        end
    end
    
    R_err = R_err_min;
    
end


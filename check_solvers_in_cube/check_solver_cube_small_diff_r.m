function [ R_err, t_err ] = check_solver_cube_small_diff_r( R )

    [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e ] = R.get_lines();

    i = R.noize;
    l1 = get_lines_from_camera(camera1s{i}, camera1e{i});
    l2 = get_lines_from_camera(camera2s{i}, camera2e{i});
    l3 = get_lines_from_camera(camera3s{i}, camera3e{i});

    [r11,r12,r13,r21,r22,r23] = solver_get_r_equations_small1(l1, l2, l3);

    R_err_min = inf;
   
    if length(r11) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(r11)
        R_test1 = get_r_small(r11(i), r12(i), r13(i));
        R_test3 = get_r_small(r21(i), r22(i), r23(i));
        
        [t_test1, t_test3] = find_t(R_test1, R_test3, l1, l2, l3);
            
        [ R_err1, t_err1 ] = test(R1, t1, R_test1, t_test1);
        [ R_err3, t_err2 ] = test(R3, t3, R_test3, t_test3);
        
        R_err = R_err1 + R_err3;
        
        if (R_err < R_err_min)
            R_err_min = R_err;
            t_err = t_err1+t_err2;
        end
    end
    
    R_err = R_err_min;

end

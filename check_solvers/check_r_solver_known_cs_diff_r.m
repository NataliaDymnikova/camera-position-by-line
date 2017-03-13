function [ R_err, k ] = check_r_solver_known_cs_diff_r( )

    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines('r_known_cs_diff_r()');

    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});

    %check l

    [c1,c2,s2,s1] = solver_get_r_equations_known_cs_diff_r4(l1, l2, l3);

    R_min = eye(3);
    R_err_min = inf;
    k = 0;

    if length(c1) == 0
        R_err = Inf;
        return
    end
    
    R1 = R(:,:,1);
    R2 = R(:,:,2);
    for i = 1:length(c1)
        R_test1 = get_r_known_cs(c1(i), s1(i));
        R_test2 = get_r_known_cs(c2(i), s2(i));
        [ R_err1, t_err1 ] = test( R1, t1, R_test1, t1);
        [ R_err2, t_err2 ] = test( R2, t1, R_test2, t1);
        R_err = max(R_err1, R_err2);
        
        if (R_err < R_err_min)
            R_err_min = R_err;
            R_min = R;
            k = i;
        end
    end
    R_err = R_err_min;
end


function [ R_err ] = check_solver_cube_known_diff_r( R )

    [ R1, R2, R3, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e ] = R.get_lines();

    R1_x = make_r.r_known(R1);
    R1_yz = R1 * R1_x';
    R2_x = make_r.r_known(R1);
    R2_yz = R2 * R2_x';
    R3_x = make_r.r_known(R3);
    R3_yz = R3 * R3_x';
    
    i = R.noize;
    l1 = get_lines_from_camera(camera1s{i}, camera1e{i});
    l2 = get_lines_from_camera(camera2s{i}, camera2e{i});
    l3 = get_lines_from_camera(camera3s{i}, camera3e{i});

    for i = 1:3
        l1(:,i) = R1_yz' * l1(:,i);
        l2(:,i) = R2_yz' * l2(:,i);
        l3(:,i) = R3_yz' * l3(:,i);
    end
    
    [c1, s1, c2, s2] = solver_get_r_equations_known_cs_diff_r1(l1, l2, l3);

    R_err_min = inf;
   
    if length(c1) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(c1)
        R_test1 = get_r_known_cs_diff_r(c1(i), s1(i));
        R_test2 = get_r_known_cs_diff_r(c2(i), s2(i));
        [ R_err1, t_err ] = test( R2_x' * R1_x, t1, R_test1, t1);
        [ R_err2, t_err ] = test( R2_x' * R3_x, t1, R_test2, t1);
        
        R_err = R_err1 + R_err2;
        
        if (R_err < R_err_min)
            R_err_min = R_err;
        end
    end
    
    R_err = R_err_min;

end
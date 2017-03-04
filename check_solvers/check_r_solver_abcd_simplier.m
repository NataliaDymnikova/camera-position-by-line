function [R_err, k] = check_r_solver_abcd_simplier( )

    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines('r_abcd()');
 
    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});
   
    %check l
    
    [r11, r12, r13, r21, r22, r23] = solver_get_r_equations_abcd_simplier(l1, l2, l3);
    
    R_min = eye(3);
    R_err_min = inf;
    k = 0;
    
    if length(r11) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(r11)
        R_test = get_r_abcd_simplier(r11(i), r12(i), r13(i), r21(i), r22(i), r23(i));
        [ R_err, t_err ] = test( R, t1, R_test, t1);
        if (R_err < R_err_min)
            R_err_min = R_err;
            R_min = R;
            k = i;
        end
    end
    R_err = R_err_min;
end


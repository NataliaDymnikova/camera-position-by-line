function [R_err, k] = check_r_solver_abcd( )

    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines('r_abcd()');
 
    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});
   
    %check l
    
    [a, b, c, d] = solver_get_r_equations_abcd(l1, l2, l3);
    
    if length(a) == 0
        R_err = Inf;
        return
    end
    
    R_min = eye(3);
    R_err_min = inf;
    k = 0;
    for i = 1:length(a)
        R_test = get_r_abcd(a(i),b(i),c(i),d(i));
        [ R_err, t_err ] = test( R, t1, R_test, t1);
        if (R_err < R_err_min)
            R_err_min = R_err;
            R_min = R;
            k = i;
        end
    end
    R_err = R_err_min;
end


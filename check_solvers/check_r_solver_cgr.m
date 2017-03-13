function [R_err, k] = check_r_solver_cgr()

    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines('r_cgr()');
 
    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});
   
    %check l
    
    [s1, s2, s3] = solver_get_r_equations_cgr(l1, l2, l3);
    
    R_min = eye(3);
    R_err_min = inf;
    k = 0;
    R = R(:,:,1);
    
    if length(s1) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(s1)
        R_test = get_r_cgr(s1(i),s2(i),s3(i)) / (1+s1(i)^2+s2(i)^2+s3(i)^2);
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

function [R_err] = check_r_solver()

    addpath('create_cameras_and_lines');
    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines();
 
    l1 = get_lines_from_camera(camera1s{1}, camera1e{1});
    l2 = get_lines_from_camera(camera2s{1}, camera2e{1});
    l3 = get_lines_from_camera(camera3s{1}, camera3e{1});
   
    %check l
    
    
    [a, b, c, d] = solver_get_r_equations(l1, l1, l1);
    if isempty(a)
        R_err = Inf;
        return
    end
    R_test = get_r_(a,b,c,d);
    [ R_err, t_err ] = test( R, t1, R_test, t1);
end

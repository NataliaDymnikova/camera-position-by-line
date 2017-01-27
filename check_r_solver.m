function [R_err] = check_r_solver()

    addpath('create_cameras_and_lines');
    [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines();

    
    l1 = get_lines(camera1s{1}, camera1e{1});
    l2 = get_lines(camera2s{1}, camera2e{1});
    l3 = get_lines(camera3s{1}, camera3e{1});
   
    [a, b, c, d] = solver_get_r_equations(l1, l1, l1);
    if isempty(a)
        R_err = Inf;
        return
    end
    R_test = get_r_(a,b,c,d);
    [ R_err, t_err ] = test( R, t1, R_test, t1);
end



function l = get_lines(start, endl)
    l = [];
    for i = 1:3
        x1 = start(2*i-1);
        y1 = start(2*i);
        x2 = endl(2*i-1);
        y2 = endl(2*i);
        l = [l, [y2 - y1; x1 - x2; y1 * x2 - x1 * y2]];
    end
end
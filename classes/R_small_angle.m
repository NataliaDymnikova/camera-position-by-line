classdef R_small_angle
    properties
        solver = @solver_get_r_equations_small1;
        points;
        R;
        noize = 1;
    end
    
    methods
        function obj = R_small_angle(points_func, i)
            obj.points = points_func;
            obj.noize = i;
        end
        function [R] = get_R(obj)
            r1 = rand();
            r2 = rand();
            r3 = rand();

            R = [1,-r3,r2;
                r3,1,-r1;
                -r2,r1,1];

            obj.R = R;
        end
        function  [ R_err ] = checker(obj)
            R_err = check_solver_cube_small_diff_r(obj);
        end
        function [ R1,R2,R3, t1,t2,t3, start_p,end_p, cam1s,cam1e,cam2s,cam2e,cam3s,cam3e ] = get_lines(obj)
           [ R1,R2,R3, t1,t2,t3, start_p,end_p, cam1s,cam1e,cam2s,cam2e,cam3s,cam3e ] = cameras_and_lines_small_angle_diff(obj.points); 
        end
    end
    
end


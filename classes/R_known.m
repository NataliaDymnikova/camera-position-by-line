classdef R_known
    properties
        solver = @() solver_get_r_equations_known_cs_diff_r(points);
        points;
        R;
        noize;
    end
    
    methods
        function obj = R_known(points_func, i)
            obj.points = points_func;
            obj.noize = i;
        end
        function [R] = get_R(obj, R1)
            y = sqrt((R1(3,2) * R1(2,1) - R1(3,3)*R1(1,1)*R1(3,1)) / R1(1,3));
            R = [R1(1,1)/y, -R1(2,1)/y, 0; R1(2,1)/y, R1(1,1)/y,0;0,0,1];
            
            obj.R = R;
        end
        function  [ R_err, t_err ] = checker(obj)
            [R_err, t_err] = check_solver_cube_known_diff_r(obj);
        end
        function [ R1,R2,R3, t1,t2,t3, start_p,end_p, cam1s,cam1e,cam2s,cam2e,cam3s,cam3e ] = get_lines(obj)
           [ R1,R2,R3, t1,t2,t3, start_p,end_p, cam1s,cam1e,cam2s,cam2e,cam3s,cam3e ] = cameras_and_lines_known_diff(obj.points); 
        end
    end
    
end


classdef R_abcd
    properties
        solver = @() solver_get_r_equations_abcd(points);
        points;
        R;
        noize;
    end
    
    methods
        function obj = R_abcd(points_func, i)
            obj.points = points_func;
            obj.noize = i;
        end
        function R = get_r(obj)
            a = randi(100);
            b = randi(100);
            c = randi(100);
            d = randi(100);

            n = sqrt(a^2 + b^2 + c^2 + d^2);
            a = a/n;
            b = b/n;
            c = c/n;
            d = d/n;

            R = [a^2 + b^2 - c^2 - d^2, 2*b*c - 2*a*d, 2*b*d + 2*a*c;
                2*b*c + 2*a*d, a^2 - b^2 + c^2 - d^2, 2*c*d - 2*a*b;
                2*b*d - 2*a*c, 2*c*d + 2*a*b, a^2 - b^2 - c^2 + d^2];
            
            obj.R = R;
        end
        function  [ R_err ] = checker(obj)
            R_err = check_solver_cube_abcd_equal_r(obj);
        end
        function [ R1,R2,R3, t1,t2,t3, start_p,end_p, cam1s,cam1e,cam2s,cam2e,cam3s,cam3e ] = get_lines(obj)
           [ R1,R2,R3, t1,t2,t3, start_p,end_p, cam1s,cam1e,cam2s,cam2e,cam3s,cam3e ] = cameras_and_lines_abcd_equal(obj.points); 
        end
    end
    
end


function [p0,p10,p5,p4,p3] = check_solver_many_times( R )

%            checker                   --  0  ^-10  ^-5  ^-4  ^-3
% 'check_solver_cube_known_diff_r(1)'  -- 16%  16%  56%  83%  96% on plane
% the same
% 'check_solver_cube_abcd_equal_r(1)'  -- 55%  55%  55%  56%  70%
% 'check_solver_cube_small_diff_r(1)'  -- 99%  99%  99%  99%  99%
% 
% 'check_solver_cube_known_diff_r(2)'  -- 0
% 'check_solver_cube_abcd_equal_r(2)'  -- 12%
% 'check_solver_cube_small_diff_r(2)'  -- 70%,  on plane 73
% 
% 'check_solver_cube_small_diff_r(3)'  -- 64%, on plane 68

% R_known(@get_points_on_plane, 1)


p10 = 0;
p5 = 0;
p4 = 0;
p3 = 0;
p0 = 0;
b = 0;

for i = 1:1000
    [err, terr] = R.checker();
    if err == 0
        p0 = p0 + 1;
        p3 = p3 + 1;
        p4 = p4 + 1;
        p5 = p5 + 1;
        p10 = p10 + 1;
    else
        if err < 1.e-10
            p3 = p3 + 1;
            p4 = p4 + 1;
            p5 = p5 + 1;
            p10 = p10 + 1;
        else
            if err < 1.e-5
                p3 = p3 + 1;
                p4 = p4 + 1;
                p5 = p5 + 1;
            else
                if err < 1.e-4
                    p3 = p3 + 1;
                    p4 = p4 + 1;
                else
                    if err < 1.e-3
                        p3 = p3 + 1;
                    else
                        if err == Inf
                            b = b + 1;
                        end
                    end
                end
            end
        end
    end
       
    if mod(i, 10) == 0
        disp([num2str(i), ' ', num2str(p5), ' ', num2str(p0)]);
    end
end

end


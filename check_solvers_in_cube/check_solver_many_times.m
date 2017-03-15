function [p0,p10,p5,p4,p3] = check_solver_many_times( checker )

%            checker                  --  0  ^-10  ^-5  ^-4  ^-3
% 'check_solver_cube_known_diff_r()'  -- 34%  34%  59%  89%  97%
% 'check_solver_cube_known_equal_r()' -- 52%  52%  96%  99%  100%
% 'check_solver_cube_abcd_equal_r()'  -- 55%  55%  55%  55%  68%  ??????? ????????!!
% 'check_solver_cube_cgr_equal_r()'   -- 

p10 = 0;
p5 = 0;
p4 = 0;
p3 = 0;
p0 = 0;

for i = 1:100
    [err] = eval(checker);
    if err == 0
        p0 = p0 + 1;
        p3 = p3 + 1;
        p4 = p4 + 1;
        p5 = p5 + 1;
        p10 = p10 + 1;
    else
        if err < 0.0000000001
            p3 = p3 + 1;
            p4 = p4 + 1;
            p5 = p5 + 1;
            p10 = p10 + 1;
        else
            if err < 0.00001
                p3 = p3 + 1;
                p4 = p4 + 1;
                p5 = p5 + 1;
            else
                if err < 0.0001
                    p3 = p3 + 1;
                    p4 = p4 + 1;
                else
                    if err < 0.001
                        p3 = p3 + 1;
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


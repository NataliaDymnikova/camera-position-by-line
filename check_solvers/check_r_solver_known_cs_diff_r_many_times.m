function [ p5,p4,p3,p0 ] = check_r_solver_known_cs_diff_r_many_times( )

p5 = 0;
p4 = 0;
p3 = 0;
p0 = 0;

for i = 1:1000
    [err] = check_r_solver_known_cs_diff_r();
    if err < 0.00001
        p5 = p5 + 1;
        p4 = p4 + 1;
        p3 = p3 + 1;
        p0 = p0 + 1;
    else
        if err < 0.0001
            p4 = p4 + 1;
            p3 = p3 + 1;
            p0 = p0 + 1;
        else
            if err < 0.001
                p3 = p3 + 1;
                p0 = p0 + 1;
            else 
                if err == 0
                    p0 = p0 + 1;
                end
            end
        end
    end
    
    
    if mod(i, 10) == 0
        disp([num2str(i), ' ', num2str(p5), ' ', num2str(p0)]);
    end
end

end


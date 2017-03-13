function [ percent, c, g ] = check_r_solver_known_cs_many_times( )
f = 0;
t = 0;
c = 0;
g = 0;
for i = 1:1000
    [err] = check_r_solver_known_cs();
    if err > 0.00001
        f = f + 1;
    else
        t = t + 1;
    end
    
    if err == inf
        c = c + 1;
    else
        if err == 0
            g = g + 1;
        end
    end
    
    if mod(i, 10) == 0
        disp([num2str(i), ' ', num2str(c), ' ', num2str(g)]);
    end

end

percent = t / (f+t);
g = g / (f+t);
end


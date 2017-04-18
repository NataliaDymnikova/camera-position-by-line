function [avg, c, p0, p3, inf] = real_tests_many(file, num) 
%    name           num  -- avg    c   p0  inf -- avg    c   p0  inf
% './cpp/floor/',   1000 -- 0.5439 50% 24% 49% -- 0.4560 47% 23% 53%
% './cpp/cabinet/', 1000 -- 0.5157 48% 23% 52% -- 0.4220 49% 26% 51%
% './cpp/large/',   1000 -- 0.5612 49% 23% 51% -- 0.4906 38% 16% 62%

inf = 0;
avg = 0;
c = 0;

p10 = 0;
p5 = 0;
p4 = 0;
p3 = 0;
p0 = 0;

for i = 1:num
    if mod(i, 10) == 0
        disp([num2str(i), ' ', num2str(p0), ' ', num2str(inf)]);
    end

    err = real_test(file, i);
    if err ~= Inf
        avg = avg + err;
        c = c + 1;
    else
        inf = inf + 1;
        continue;
    end
    
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
                    end
                end
            end
        end
    end
    
end
   

avg = avg / c;

end
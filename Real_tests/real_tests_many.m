function [avg, c, p0, p3] = real_tests_many(file) % 100                     1000
%    name           num  -- avg    c   p0  inf |--| avg    c    p0  inf |--| avg    c    p0  inf
% './cpp/floor/',   1000 -- 0.5439 50% 24% 49% |--| 1.4    100% 32% 0%  |--| 0.5765 100% 39% 0%
% './cpp/cabinet/', 1000 -- 0.5157 48% 23% 52% |--| 0.4307 100% 49% 0%  |--| 0.5797 99%  38% 1%
% './cpp/large/',   1000 -- 0.5612 49% 23% 51% |--| 0.5881 100% 39% 0%  |--| 0.6002 100% 38% 0%

% known vertival direction
%    name           num  -- avg    c    p0  inf |--| avg    c    p0  inf |--|
% './cpp/floor/',   1000 -- 0.5345 100% 38%  0% |--| 0.6831 100% 31% 0%  |--|

step = 1;

num = min(100 * step, 1000);

inf = 0;
avg = 0;
c = 0;

p10 = 0;
p5 = 0;
p4 = 0;
p3 = 0;
p0 = 0;

for i = 40:step:num+40
    if mod(i, 10) == 0
        disp([num2str(i), ' ', num2str(p0), ' ', num2str(inf)]);
    end

    %err = real_test(file, i, step);
    err = real_tests_known(file, i, step);
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
                if err < 1.e-1
                    p3 = p3 + 1;
                    p4 = p4 + 1;
                else
                    if err < 1.1
                        p3 = p3 + 1;
                    end
                end
            end
        end
    end
    
end
   

avg = avg / c;

end
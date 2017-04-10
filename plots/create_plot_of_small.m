noize = [0:0.1:3];
len = length(noize);
num = 100;

yr = zeros(1,len);

for i = 1:len
    R = R_small_angle(@get_points_in_cube, i);
    s = 0;
    inf = 0;
    for j = 1:num
        [Err] = R.checker();
        if Err == Inf
            inf = inf + 1;
        else
            s = s + Err;
        end
    end
    yr(i) = s / (num - inf);
    disp([num2str(i), ' ', num2str(s/(num-inf)), ' ', num2str(inf)]);
    
end

plot(noize, yr)
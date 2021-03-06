function [ best_lines, R_res1, R_res3, sum_sq, good_lines ] = ransac( lines, solver, num_iter, num_ress, t1, t3, lim_k )
    
    number = length(lines(1, :));
    best_lines = [];
    sum_sq = Inf;
    good_all = 0;
    good_lines = [];
    
    for i = 1:num_iter
        % Randomly select num_ress lines
        idx = randperm(number,num_ress); 
        l1 = lines(1:3, idx);
        l2 = lines(4:6, idx);
        l3 = lines(7:9, idx);

        [R1, R3] = solver(l1,l2,l3);
        if abs(R1(1,2)) > 1 || abs(R3(1,2)) > 1
            continue;
        end
        distance = 0;
        good = 0;
        g_lines = [];
        for j = 1:number
            l1 = lines(1:3, j);
            l2 = lines(4:6, j);
            l3 = lines(7:9, j);
            %idx = randperm(number,5); 
            %l1 = lines(1:3, idx);
            %l2 = lines(4:6, idx);
            %l3 = lines(7:9, idx);

            k = abs(cross(R3'*l3(:,1), R1'*l1(:,1))' * l2(:,1));
            %[t1, t3, t1e, t3e] = find_t(R1,R3, t1, t3, l1,l2,l3);
            %l1 = lines(1:3, j);
            %l2 = lines(4:6, j);
            %l3 = lines(7:9, j);
            %tens = l2' - [l1'*(R1(:,1)*t3' - t1*R3(:,1)')*l3, l1'*(R1(:,2)*t3' - t1*R3(:,2)')*l3, l1'*(R1(:,3)*t3' - t1*R3(:,3)')*l3];
            %k = sum(abs(tens));
            %lim_k = 0.1;
            if k < lim_k
                distance = distance + k;
                good = good + 1;
                g_lines = [g_lines, j];
            end
            
        end

        if good >= good_all
            %if distance < sum_sq
                good_all = good;
                sum_sq = distance;
                best_lines = idx;
                R_res1 = R1;
                R_res3 = R3;
                good_lines = g_lines(:);
            %end
        end
    end

    
end


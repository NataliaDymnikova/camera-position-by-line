function [ best_lines, R_res1, R_res3, sum_sq ] = ransac( lines, solver, num_iter, num_ress)
    
    number = length(lines(1, :));
    best_lines = [];
    sum_sq = Inf;
    good_all = 0;
    for i = 1:num_iter
        % Randomly select num_ress lines
        idx = randperm(number,num_ress); 
        l1 = lines(1:3, idx);
        l2 = lines(4:6, idx);
        l3 = lines(7:9, idx);

        [R1, R3] = solver(l1,l2,l3);
        distance = 0;
        good = 0;
        for j = 1:number
            l1 = lines(1:3, j);
            l2 = lines(4:6, j);
            l3 = lines(7:9, j);

            k = (cross(R3'*l3(:,1), R1'*l1(:,1))' * l2(:,1)) ^ 2;
            %tens = l2' - (l1'*(R1(:,1)*t3' - t1*R3(:,1)')*l3 + l1'*(R1(:,2)*t3' - t1*R3(:,2)')*l3+ l1'*(R1(:,3)*t3' - t1*R3(:,3)')*l3);
            %k = sum(abs(tens));
            if k < 1e+12
                distance = distance + k;
                good = good + 1;
            end
            
        end

        if good >= good_all
            good_all = good;
            if distance < sum_sq
                sum_sq = distance;
                best_lines = idx;
                R_res1 = R1;
                R_res3 = R3;
            end
        end
    end

end


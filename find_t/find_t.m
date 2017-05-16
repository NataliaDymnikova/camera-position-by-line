function [t1_guess, t3_guess, t1errs, t3errs] = find_t( R1, R3, t1, t3, l1, l2, l3 )

    rind = 1;
    A = [];
    for li = 1:5
        for ci = 1:3
            a = l1(:, li)'*R1(:, ci);
            A(rind, 4:6) = a*l3(:, li);
            b = -R3(:, ci)'*l3(:, li);
            A(rind, 1:3) = b*l1(:, li);
            A(rind, li+6) = - l2(ci, li);
            rind = rind+1;
        end
    end

    [U,S,V] = svd(A);
    x_ans = V(:, end);
    t1f = x_ans(1:3);
    t3f = x_ans(4:6);
    
    
    t1_guess = t1f/norm(t1f)*norm(t1);
    [~,mct1] = max(abs(t1_guess));
    s = 1.0;
    if (t1_guess(mct1)*t1(mct1)<0)
        s = -1;
    end
    t1_guess = s*t1_guess;
    t3_guess = s*t3f/norm(t3f)*norm(t3);
    
    t1errs = norm(t1_guess-t1)/norm(t1);
    t3errs = norm(t3_guess-t3)/norm(t3);
end


function [ R_err ] = real_test( file, i, step )
	% './cpp/floor/', 1..97
    ffile_lines = fopen(file+string(step)+'/'+string(i-1),'r');
    ffile_res = fopen(file+string('groundtruth.txt'),'r');
    % time t1 t2 t3 a b c d
    Res = fscanf(ffile_res, '%d.%d %f %f %f %f %f %f %f', [9, Inf]);
    % l1,l2,l3, R1,R2,R3
    R1 = get_r_abcd(Res(6,i), Res(7,i), Res(8,i), Res(9,i));
    R2 = get_r_abcd(Res(6,i+1*step), Res(7,i+1*step), Res(8,i+1*step), Res(9,i+1*step));
    R3 = get_r_abcd(Res(6,i+2*step), Res(7,i+2*step), Res(8,i+2*step), Res(9,i+2*step));
    t1 = [1;1;1];
    
    lines = fscanf(ffile_lines, '%f %f %f %f %f %f %f %f %f', [9, Inf]);
    if length(lines(1,:)) < 6
        R_err = Inf;
        disp('Inf');
        fclose('all');
        return
    end
    for j = 1:length(lines(1,:))
        lines(1:3, j) = lines(1:3, j) / norm(lines(1:3, j));
        lines(4:6, j) = lines(4:6, j) / norm(lines(4:6, j));
        lines(7:9, j) = lines(7:9, j) / norm(lines(7:9, j));
    end
    R1 = R1*R2';
    R3 = R3*R2';
    
    num_iter = 25;
    num_ress = 6;
    [ best_lines, R_res1, R_res3, sum_sq ] = ransac( lines, @(l1,l2,l3) (solver(l1,l2,l3,R1,R3,t1)), num_iter, num_ress);
    
    [ R_err1, t_err ] = test(R1, t1, R_res1, t1);
    [ R_err3, t_err ] = test(R3, t1, R_res3, t1);

    R_err = R_err1 + R_err3;
        
    
    fclose('all');
end

function [R1res, R3res] = solver(l1, l2, l3, R1, R3, t1)
     
    [r11,r12,r13,r21,r22,r23] = solver_get_r_equations_small1(l1, l2, l3);
    R1res = [];
    R3res = [];
    R_err_min = inf;
   
    if length(r11) == 0
        R1res = eye(3);
        R3res = eye(3);
        return
    end
    
    for i = 1:length(r11)
        R_test1 = get_r_small(r11(i), r12(i), r13(i));
        R_test3 = get_r_small(r21(i), r22(i), r23(i));
        
        R_test1 = build_R(R_test1);
        R_test3 = build_R(R_test3);
        
        [ R_err1, t_err ] = test(R1, t1, R_test1, t1);
        [ R_err3, t_err ] = test(R3, t1, R_test3, t1);
        
        R_err = R_err1 + R_err3;
        
        if (R_err < R_err_min)
            R_err_min = R_err;
            R1res = R_test1;
            R3res = R_test3;
        end
    end
end

function [ R ] = build_R(R_test1)
    [U,S,V] = svd(R_test1);
    R = U*V';

    
end
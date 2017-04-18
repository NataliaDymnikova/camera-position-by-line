function [ R_err ] = real_test( file, i )
	% './cpp/floor/', 0..97
    ffile = fopen(file+string(i-1),'r');
    ffile_res = fopen(file+string('groundtruth.txt'),'r');
    % time t1 t2 t3 a b c d
    Res = fscanf(ffile_res, '%d.%d %f %f %f %f %f %f %f', [9, Inf]);
    % l1,l2,l3, R1,R2,R3
    R1 = get_r_abcd(Res(6,i), Res(7,i), Res(8,i), Res(9,i));
    R2 = get_r_abcd(Res(6,i+1), Res(7,i+1), Res(8,i+1), Res(9,i+1));
    R3 = get_r_abcd(Res(6,i+2), Res(7,i+2), Res(8,i+2), Res(9,i+2));
    t1 = [1;1;1];
    
    lines = fscanf(ffile, '%f %f %f %f %f %f %f %f %f', [9, 6]);
    if length(lines(1,:)) < 6
        R_err = Inf;
        fclose('all');
        return
    end
    l1 = lines(1:3, 1:6);
    l2 = lines(4:6, 1:6);
    l3 = lines(7:9, 1:6);
    
    R1 = R1*R2';
    R3 = R3*R2';
    
    [r11,r12,r13,r21,r22,r23] = solver_get_r_equations_small1(l1, l2, l3);
    
    R_err_min = inf;
   
    if length(r11) == 0
        R_err = Inf;
        return
    end
    
    for i = 1:length(r11)
        R_test1 = get_r_small(r11(i), r12(i), r13(i));
        R_test3 = get_r_small(r21(i), r22(i), r23(i));
        [ R_err1, t_err ] = test(R1, t1, R_test1, t1);
        [ R_err3, t_err ] = test(R3, t1, R_test3, t1);
        
        R_err = R_err1 + R_err3;
        
        if (R_err < R_err_min)
            R_err_min = R_err;
        end
    end
    R_err = R_err_min;
    
    fclose('all');
end


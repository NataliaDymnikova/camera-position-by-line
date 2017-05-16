function [ R_err, t_err ] = real_tests_known( file, i, step )
    ffile = fopen(file+string(step)+'/'+string(i-1),'r');
    ffile_res = fopen(file+string('groundtruth.txt'),'r');
    % time t1 t2 t3 a b c d
    Res = fscanf(ffile_res, '%d.%d %f %f %f %f %f %f %f', [9, Inf]);
    % l1,l2,l3, R1,R2,R3
    R1 = get_r_abcd(Res(6,i), Res(7,i), Res(8,i), Res(9,i));
    R2 = get_r_abcd(Res(6,i+1*step), Res(7,i+1*step), Res(8,i+1*step), Res(9,i+1*step));
    R3 = get_r_abcd(Res(6,i+2*step), Res(7,i+2*step), Res(8,i+2*step), Res(9,i+2*step));
    t1 = [Res(3,i);Res(4,i);Res(5,i)];
    t2 = [Res(3,i+1*step);Res(4,i+1*step);Res(5,i+1*step)];
    t3 = [Res(3,i+2*step);Res(4,i+2*step);Res(5,i+2*step)];    
    
    file_acc = fopen(file+string('accelerometer.txt'),'r');
    Acc = fscanf(file_acc , '%d.%d %f %f %f', [5, Inf]);
    R1_acc = Acc(3:5, i);
    R2_acc = Acc(3:5, i+1*step);
    R3_acc = Acc(3:5, i+2*step);
    
    lines = fscanf(ffile, '%f %f %f %f %f %f %f %f %f', [9, Inf]);
    if length(lines(1,:)) < 6
        R_err = Inf;
        fclose('all');
        return
    end
          
    %R1_x2 = r_x(R1_acc)*r_x(R2_acc)';
    %R3_x2 = r_x(R3_acc)*r_x(R1_acc)';

    R1_x2 = r_x(R2(:,2))' * r_x(R1(:,2));
    R3_x2 = r_x(R1(:,2))'*r_x(R3(:,2));
    
    R1 = R1*R2';
    R3 = R3*R2';
    t1 = t1-t2;
    t3 = t3-t2;
    
    num_iter = 50;
    num_ress = 4;
    k_lim = 1e-12;
    [ best_lines, R_res1, R_res3, sum_sq, good_lines ] = ransac( lines, @(l1,l2,l3) (solver(l1,l2,l3,t1,t3,R1,R2,R3,R1_x2,R3_x2)), num_iter, num_ress, t1,t3,k_lim);
    
    
    %draw_lines(i, step, good_lines, lines);
    
    [ R_err1, t_err ] = test(R1, t1, R1_x2*R_res1, t1);
    [ R_err3, t_err3 ] = test(R3, t1, R3_x2*R_res3, t1);

    R_err = R_err1 + R_err3;
        
    
    fclose('all');
end

function [R1res, R3res] = solver(l1, l2, l3, t1, t3, R1,R2,R3,R1_xz,R3_xz)
    
    for i = 1:length(l1)
        l1(:,i) = R1_xz' * l1(:,i);
        %l2(:,i) = R2' * l2(:,i);
        l3(:,i) = R3_xz' * l3(:,i);
    end

    [c1,c2,s1,s2] = solver_get_r_equations_known_cs_diff_r_vert(l1, l2, l3);
    R1res = eye(3);
    R3res = eye(3);
    R_err_min = inf;
   
    if length(c1) == 0
        R1res = eye(3);
        R3res = eye(3);
        disp('Doesnt found!!!!!!!');
        return
    end
    
    for i = 1:length(c1)
        if abs(c1(1)^2+s1(1)^2 - 1) > 0.2 || abs(c2(1)^2+s2(1)^2 - 1) > 0.2
            continue;
        end
        R_test1 = get_r_known_cs_diff_r(c1(i), s1(i));
        R_test3 = get_r_known_cs_diff_r(c2(i), s2(i));
        [ R_err1, t_err1 ] = test(R1, t1, R1_xz*R_test1, t1);
        [ R_err3, t_err3 ] = test(R3, t3, R3_xz*R_test3, t3);

        R_err = R_err1 + R_err3;
        
        if (R_err < R_err_min)
            R_err_min = R_err;
            R1res = R_test1;
            R3res = R_test3;
        end
    end
end

function [Rxz] = r_x(v)

    if (norm(v) == 0)
        Rxz = eye(3);
        return;
    end
    
    v = v / norm(v);
    
    z = [0;0;1];
    if (all(cross(v,z) == 0))
        z = [1;0;0];
    end
    v3 = cross(v,z);
    v3 = v3/norm(v3);
    v1 = cross(v, v3);
    R0 = [v1,v,v3]';
    
    Rxz = R0';
        
end


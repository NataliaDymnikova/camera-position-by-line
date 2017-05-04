function [t1, t3] = find_t( R1, R3, l1, l2, l3 )

    syms t11 t12 t13 t31 t32 t33 real;
    t3 = [t31;t32;t33];
    
    j = 1;
    for i = 1:3
        t1(i, :) = (R1(:,i) * t3' - (l2(i,j) / l1(:,j))' / l3(:,j)) * (eye(3) / R3(:,i)');
    end
    t11 = t1(1,1);
    t12 = t1(2,2);
    t13 = t1(3,3);
    
    t1 = [t11;t12;t13];
       
    j = 2
    i = 1
    t3 = ((eye(3) / R1(:,i)')' * ((l2(i,j) / l1(:,j))' / l3(:,j) + t1 * R3(:,i)'))';
    t31 = t3(1);
    t11 = eval(t11);
    
    i = 2
    t3 = ((eye(3) / R1(:,i)')' * ((l2(i,j) / l1(:,j))' / l3(:,j) + t1 * R3(:,i)'))';
    t32 = t3(2);
    t12 = eval(t12);

    i = 3
    t3 = ((eye(3) / R1(:,i)')' * ((l2(i,j) / l1(:,j))' / l3(:,j) + t1 * R3(:,i)'))';
    t33 = t3(3);
    t13 = eval(t13);

    
end


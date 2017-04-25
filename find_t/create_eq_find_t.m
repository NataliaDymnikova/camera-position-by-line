function [eqs, known, unknown, kngroups, cfg, algB] = create_eq_find_t( )

    R1 = gbs_Matrix('r1_%d%d', 3, 3, 'real');    
    R3 = gbs_Matrix('r3_%d%d', 3, 3, 'real');    
    l1 = gbs_Matrix('l1_%d%d', 3, 3, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 3, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 3, 'real');    
    
    syms t11 t12 t13 t31 t32 t33 real;
    t1 = [t11;t12;t13];
    t3 = [t31;t32;t33];
    
    for i = 1:3
        for j = 1:2
            T = R1(:,j) * t3' - t1 * R3(:,j)';
            eqs(2*i + j - 2) = l1(:,i)' * T * l3(:,i) - l2(j,i);
        end
    end
    
    unknown = {'t11' 't12' 't13' 't31' 't32' 't33'};

    known = {};
    vars = transpose([R1(:); R3(:); l1(:); l2(:); l3(:)]);
    for var = vars
        known = [known {char(var)}];
    end

    % define variable groups (optional)
    kngroups = zeros(18+9*3,1);    
    kngroups(1:9) = 1;    
    kngroups(10:18) = 2;   
    kngroups(19:27) = 3;   
    kngroups(28:36) = 4;   
    kngroups(37:45) = 5;    

    cfg = gbs_InitConfig();
    %cfg.InstanceGenerator = @;

    % no algB yet computed
    algB = [];   

end


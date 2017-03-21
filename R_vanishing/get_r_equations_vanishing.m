function [ eqs, known, unknown, kngroups, cfg, algB ] = get_r_equations_vanishing( )

    l1 = gbs_Matrix('l1_%d%d', 3, 6, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 6, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 6, 'real');    

    syms r11 r12 r13 r21 r22 r23 real;
    syms v11 v12 v13 v21 v22 v23 real;
    
    R1 = get_r_vanishing(v11,v12,v13, r11,r12,r13);
    R3 = get_r_vanishing(v21,v22,v23, r21,r22,r23);

    for j = 1:6
        eqs(j) = cross(R3'*l3(:,j), R1'*l1(:,j))' * l2(:,j);
    end
    
    unknown = {'r11' 'r12' 'r13' 'r21' 'r22' 'r23'};

    known = {};
    vars = transpose([l1(:); l2(:); l3(:)]);
    for var = vars
        known = [known {char(var)}];
    end
    known = [known {'v11' 'v12' 'v13' 'v21' 'v22' 'v23'}];
    
    % define variable groups (optional)
    kngroups = zeros(60,1);    
    kngroups(1:18) = 1;    
    kngroups(19:36) = 2;    
    kngroups(37:54) = 3;    
    kngroups(55:57) = 4;    
    kngroups(58:60) = 5;    

    cfg = gbs_InitConfig();
    %cfg.InstanceGenerator = @generate_instances_for_eq_small;

    % no algB yet computed
    algB = [];   


end


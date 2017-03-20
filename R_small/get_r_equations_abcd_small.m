function [eqs, known, unknown, kngroups, cfg, algB]  = get_r_equations_abcd()

    l1 = gbs_Matrix('l1_%d%d', 3, 6, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 6, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 6, 'real');    

   syms r11 r12 r13 r21 r22 23 real;
    R1 = get_r_small(r11,r12,r13);
    R3 = get_r_small(r21,r22,r23);

    for j = 1:6
        eqi(j) = cross(R3'*l3(:,j), R1'*l1(:,j))' * l2(:,j);
    end
    
    unknown = {'r11' 'r12' 'r13' 'r21' 'r22' 'r23'};

    known = {};
    vars = transpose([l1(:); l2(:); l3(:)]);
    for var = vars
        known = [known {char(var)}];
    end

    % define variable groups (optional)
    kngroups = zeros(54,1);    
    kngroups(1:18) = 1;    
    kngroups(19:36) = 2;    
    kngroups(37:54) = 3;    

    cfg = gbs_InitConfig();
    %cfg.InstanceGenerator = @generate_instances_for_eq_small;

    % no algB yet computed
    algB = [];   
end


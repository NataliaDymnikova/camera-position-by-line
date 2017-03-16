function [eqs, known, unknown, kngroups, cfg, algB]  = get_r_equations_known_cs_diff_r()

    l1 = gbs_Matrix('l1_%d%d', 3, 2, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 2, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 2, 'real');    

    syms c1 s1 c2 s2 real;

    R1 = get_r_known_cs_diff_r(c1,s1);
    R3 = get_r_known_cs_diff_r(c2,s2);

    eqs(1) = c1^2 + s1^2 - 1;
    eqs(2) = c2^2 + s2^2 - 1;

    for j = 1:2
        eqs(j + 2) = cross(R3'*l3(:,j), R1'*l1(:,j))' * l2(:,j);
    end
    
    unknown = {'c1' 's1' 'c2' 's2' };

    known = {};
    vars = transpose([l1(:); l2(:); l3(:)]);
    for var = vars
        known = [known {char(var)}];
    end

    % define variable groups (optional)
    kngroups = zeros(18,1);    
    kngroups(1:6) = 1;    
    kngroups(7:12) = 2;    
    kngroups(13:18) = 3;    
    
    cfg = gbs_InitConfig();
    %cfg.InstanceGenerator = @generate_instances_for_eq_known_cs_diff_r;

    % no algB yet computed
    algB = [];   
end


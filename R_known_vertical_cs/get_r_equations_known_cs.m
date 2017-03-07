function [eqs, known, unknown, kngroups, cfg, algB]  = get_r_equations_known_cs()

    l1 = gbs_Matrix('l1_%d%d', 3, 1, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 1, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 1, 'real');    

    syms c s real;

    R = get_r_known_cs(c,s);

    eqs(1) = c^2 + s^2 - 1;

    for j = 1:1
        eqs(j + 1) = cross(R*l3(:,j), R'*l1(:,j))' * l2(:,j);
    end
    
    unknown = {'c' 's' };

    known = {};
    vars = transpose([l1(:); l2(:); l3(:)]);
    for var = vars
        known = [known {char(var)}];
    end

    % define variable groups (optional)
    kngroups = zeros(9,1);    
    kngroups(1:3) = 1;    
    kngroups(4:6) = 2;    
    kngroups(7:9) = 3;    

    cfg = gbs_InitConfig();
    %cfg.InstanceGenerator = @generate_instances_for_eq_cgr;

    % no algB yet computed
    algB = [];   
end


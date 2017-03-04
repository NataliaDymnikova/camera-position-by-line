function [eqs, known, unknown, kngroups, cfg, algB]  = get_r_equations_abcd_simplier()

    l1 = gbs_Matrix('l1_%d%d', 3, 3, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 3, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 3, 'real');    

    syms r11 r12 r13 r21 r22 r23 real;

    R = get_r_abcd_simplier(r11, r12, r13, r21, r22, r23);
    
    for j = 1:3
        eqs(j) = cross(R*l3(:,j), R'*l1(:,j))' * l2(:,j);
    end
    r1 = [r11; r12; r13];
    r2 = [r21; r22; r23];
    eqs(4) = r1' * r2;
    eqs(5) = r1' * r1 - 1;
    eqs(6) = r2' * r2 - 1;
    
    unknown = {'r11' 'r12' 'r13' 'r21' 'r22' 'r23'};

    known = {};
    vars = transpose([l1(:); l2(:); l3(:)]);
    for var = vars
        known = [known {char(var)}];
    end

    % define variable groups (optional)
    kngroups = zeros(27,1);    
    kngroups(1:9) = 1;    
    kngroups(10:18) = 2;    
    kngroups(19:27) = 3;    

    cfg = gbs_InitConfig();
    cfg.InstanceGenerator = @generate_instances_for_eq_abcd_simplier;

    % no algB yet computed
    algB = [];   
end


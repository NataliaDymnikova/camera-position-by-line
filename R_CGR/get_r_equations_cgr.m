function [eqs, known, unknown, kngroups, cfg, algB]  = get_r_equations_cgr()

    l1 = gbs_Matrix('l1_%d%d', 3, 3, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 3, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 3, 'real');    

    syms s1 s2 s3 real;

    R = get_r_cgr(s1,s2,s3);
    
    for j = 1:3
        eqs(j) = cross(R*l3(:,j), R'*l1(:,j))' * l2(:,j);
    end
    
    unknown = {'s1' 's2' 's3'};

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
    cfg.InstanceGenerator = @generate_instances_for_eq_cgr;

    % no algB yet computed
    algB = [];   
end


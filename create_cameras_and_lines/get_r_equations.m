function [eqs, known, unknown, kngroups, cfg, algB]  = get_r_equations()

    l1 = gbs_Matrix('l1_%d%d', 3, 3, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 3, 'real');    
    l3 = gbs_Matrix('l3_%d%d', 3, 3, 'real');    

    syms a b c d real;

    R = [a^2 + b^2 + c^2 + d^2, 2*b*c - 2*a*d, 2*b*d + 2*a*c;
        2*b*c + 2*a*d, a^2 - b^2 + c^2 - d^2, 2*c*d - 2*a*b;
        2*b*d - 2*a*c, 2*c*d + 2*a*b, a^2 - b^2 - c^2 + d^2];
    
    eqs(1) = a^2 + b^2 + c^2 + d^2 - 1;
    for j = 1:3
        eqs(j + 1) = cross(R'*l3(:,j), R*l1(:,j))' * l2(:,j);
    end

    unknown = {'a' 'b' 'c' 'd'};

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

    % no algB yet computed
    algB = [];   
end


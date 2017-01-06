function [eq, known, unknown, kngroups, cfg, algB] = need_to_be_solved( )

% symbolic variables
syms a b c d;
l1 = gbs_Matrix('l1_%d%d', 1, 3);    
l2 = gbs_Matrix('l2_%d%d', 1, 3);    
l3 = gbs_Matrix('l3_%d%d', 1, 3);    

R = [a^2+b^2+c^2+d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
    2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
    2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2];

for j=1:3
    eq{j} = cross(R'*l3(:, j), R*l1(:, j))'*l2(:, j);    
end
eq{4} = a^2+b^2+c^2+d^2 - 1;
eq = [eq{:}];

unknown = {'a' 'b' 'c' 'd'};
known = {};

vars = transpose([l1(:); l2(:); l3(:);]);
for var = vars
    known = [known {char(var)}];
end

% define variable groups (optional)
kngroups = zeros(9,1);    
kngroups(1:3) = 1;    
kngroups(4:6) = 2;    
kngroups(7:9) = 3;    

cfg = gbs_InitConfig();

% no algB yet computed
algB = [];   
end


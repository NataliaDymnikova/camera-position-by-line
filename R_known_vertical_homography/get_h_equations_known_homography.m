function [eqs, known, unknown, kngroups, cfg, algB]  = get_h_equations_known_homography()

    l1 = gbs_Matrix('l1_%d%d', 3, 2, 'real');    
    l2 = gbs_Matrix('l2_%d%d', 3, 2, 'real');    
    %l3 = gbs_Matrix('l3_%d%d', 3, 2, 'real');    

    syms a b d tx ty nx ny nz real;

    H = get_h_known_homography(a,b,d,tx,ty,nx,ny,nz);

    eqs(1) = a^2 + b^2 - 1;
    eqs(2) = nx^2 + ny^2 + nz^2 - 1;

    for i=1:3
        ei = cross(l1(:,i), H*l2(:,i));
        eqs(i*2+1:2*i+2) = ei(1:2);
    end
    
    unknown = {'a' 'b' 'd' 'tx' 'ty' 'nx' 'ny' 'nz' };

    known = {};
    vars = transpose([l1(:); l2(:)]);
    for var = vars
        known = [known {char(var)}];
    end

    % define variable groups (optional)
    kngroups = zeros(12,1);    
    kngroups(1:6) = 1;    
    kngroups(7:12) = 2;    
    
    cfg = gbs_InitConfig();
    %cfg.InstanceGenerator = @generate_instances_for_eq_cgr;

    % no algB yet computed
    algB = [];   
end


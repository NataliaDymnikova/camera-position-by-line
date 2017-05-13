function [Rxz] = r_known(R1)
    
    v = R1(:,2);
    if (norm(v) == 0)
        Rxz = eye(3);
        return;
    end
    
    v = v / norm(v);
    
    z = [0;0;1];
    if (all(cross(v,z) == 0))
        z = [1;0;0];
    end
    v3 = cross(v,z);
    v3 = v3/norm(v3);
    v1 = cross(v, v3);
    R0 = [v1,v,v3]';
    
    Rxz = R0';
    
end
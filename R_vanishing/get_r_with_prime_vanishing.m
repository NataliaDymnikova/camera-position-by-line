function [ R ] = get_r_with_prime_vanishing( prime )

flag = true;
while flag
    [v1,v2,v3] = get_v(prime);
    [r1,r2,r3] = get_v(prime);
    r = mod(cross([r1,r2,r3],[v1,v2,v3]), prime);

    R = mod(get_r_vanishing(v1,v2,v3,r(1),r(2),r(3)), prime);
    d = get_cubic_root(mod(det(R), prime), prime);
    R = mod(R * inverse(d, prime), prime);
    if d < prime
        flag = false;
    end
end
end

function [v1,v2,v3] = get_v(prime)
    r = randi(100);
    w = randi(100);

    v1 = mod((1-r*r)*(1-w*w), prime);
    v2 = mod((1-r*r)*2*w, prime);
    v3 = mod(2*r, prime);

    v1 = mod(v1 * inverse(mod((1+w^2)*(1+r^2),prime), prime), prime);
    v2 = mod(v2 * inverse(mod((1+w^2)*(1+r^2), prime), prime), prime);
    v3 = mod(v3 * inverse(mod(1+r^2, prime), prime), prime);
end

function [r] = get_cubic_root(a, prime)
    flag = true;
    r = 0;
    while flag && r < prime
        if mod(r*r*r, prime) == a
            flag = false;
        else
            r = r + 1;
        end
    end
end
function [R,r1,r2] = get_r_with_prime_abcd_simplier(prime_num)
    a = randi(100);
    b = randi(100);
    c = randi(100);
    d = randi(100);
    r1 = mod([a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c], prime_num);
    r2 = mod([2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b], prime_num);
    
    R = mod([r1; r2; cross(r1,r2)*inverse(a^2+b^2+c^2+d^2, prime_num)], prime_num);
    R = mod(R*inverse(a^2+b^2+c^2+d^2, prime_num), prime_num);
end


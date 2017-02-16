function [R,a,b,c,d] = get_r_with_prime(prime_num)
    a = randi(100);
    b = randi(100);
    c = randi(100);
    d = randi(100);
    R = mod([a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
        2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
        2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2], prime_num);
    R = mod(R*inverse(a^2+b^2+c^2+d^2, prime_num), prime_num);
end


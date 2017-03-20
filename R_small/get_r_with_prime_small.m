function [R,r1,r2,r3] = get_r_with_prime_small(prime_num)
    r1 = randi(100);
    r2 = randi(100);
    r3 = randi(100);
    
    R = mod(get_r_small(r1,r2,r3), prime_num);
end


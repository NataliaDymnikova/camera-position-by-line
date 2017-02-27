function [ R,s1,s2,s3 ] = get_r_with_prime_cgr( prime_num )

s1 = randi(100);
s2 = randi(100);
s3 = randi(100);
R = mod(get_r_cgr(s1,s2,s3), prime_num);
R = mod(R*inverse(mod(1+s1^2+s2^2+s3^2, prime_num), prime_num), prime_num);

end


function [ R,c,s ] = get_r_with_prime_known_cs_diff_r( prime_num )

q = randi(100);
c = mod(1 - q*q, prime_num); 
s = mod(2*q, prime_num); 
r = mod(1 + q*q, prime_num);
R = mod([c,s,0; -s,c,0; 0,0,r], prime_num);
R = mod(R*inverse(r, prime_num), prime_num);

end


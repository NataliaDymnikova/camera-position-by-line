function [ R ] = get_r_with_prime_known_cs_diff_r_yz( prime_num )

q = randi(100);
c = mod(1 - q*q, prime_num); 
s = mod(2*q, prime_num); 
r = mod(1 + q*q, prime_num);

R_y = mod([c,0,s;0,r,0; -s,0,c], prime_num);
R_y = mod(R_y*inverse(r, prime_num), prime_num);

q = randi(100);
c = mod(1 - q*q, prime_num); 
s = mod(2*q, prime_num); 
r = mod(1 + q*q, prime_num);

R_z = mod([r,0,0;0,c,s; 0,-s,c], prime_num);
R_z = mod(R_z*inverse(r, prime_num), prime_num);

R = mod(R_y*R_z, prime_num);
end


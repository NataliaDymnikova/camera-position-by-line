function [ H,a,b,d,tx,ty,nx,ny,nz ] = get_h_with_prime_known_homography( prime_num )

q = randi(100);
a = mod(1 - q*q, prime_num);
b = mod(2*q, prime_num); 
r = mod(1 + q*q, prime_num);

a = mod(a*inverse(r, prime_num), prime_num);
b = mod(b*inverse(r, prime_num), prime_num);

d = randi(100);
tx = randi(100);
ty = randi(100);

r = randi(100);
w = randi(100);

nx = mod((1-r*r)*(1-w*w), prime_num);
ny = mod((1-r*r)*2*w, prime_num);
nz = mod(2*r, prime_num);

nx = mod(nx * inverse(mod((1+w^2)*(1+r^2),prime_num), prime_num), prime_num);
ny = mod(ny * inverse(mod((1+w^2)*(1+r^2), prime_num), prime_num), prime_num);
nz = mod(nz * inverse(mod(1+r^2, prime_num), prime_num), prime_num);

H = mod(get_h_known_homography(a,b,d,nx,ny,nz,tx,ty), prime_num);

end


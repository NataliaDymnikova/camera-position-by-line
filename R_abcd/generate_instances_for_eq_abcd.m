function eqi = generate_instances_for_eq_abcd( cfg, eq, known, unknown )

prime = 32999;%cfg.prime;

t1 = randi(10,3,1);
t3 = randi(10,3,1);

[R,a,b,c,d] = get_r_with_prime_abcd(prime);
for i = 1:3
    s = randi(100,3,1);
    e = randi(100,3,1);

    camera2s(:,i) = mod(s(1:2)*inverse(s(3), prime), prime);
    camera2e(:,i) = mod(e(1:2)*inverse(e(3), prime), prime);
    
    temp = mod(R * s + t1, prime);
    camera1s(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
    temp = mod(R * e + t1, prime);
    camera1e(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);

    temp = mod(R' * s + t3, prime);
    camera3s(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
    temp = mod(R' * e + t3, prime);
    camera3e(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
end

l1 = mod(get_lines_from_camera(camera1s, camera1e), prime);
l2 = mod(get_lines_from_camera(camera2s, camera2e), prime);
l3 = mod(get_lines_from_camera(camera3s, camera3e), prime);

syms a b c d real;
R2 = get_r_abcd(a,b,c,d);

eqi(1) = a^2 + b^2 + c^2 + d^2 - 1;
for j = 1:3
    eqi(j + 1) = cross(R2*l3(:,j), R2'*l1(:,j))' * l2(:,j);
end

end



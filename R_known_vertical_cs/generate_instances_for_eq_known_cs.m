function eqi = generate_instances_for_eq_known_cs( cfg, eq, known, unknown )

prime = cfg.prime;%32999

t1 = randi(10,3,1);
t3 = randi(10,3,1);

flag = true;
while flag
    [R] = get_r_with_prime_known_cs(prime);
    if mod(det(R),prime) == 1
        flag = false;
    end
end

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

syms c s real;
R2 = get_r_known_cs(c, s);

eqi(1) = c^2+s^2-1;
for j = 1:1
    eqi(j+1) = cross(R2*l3(:,j), R2'*l1(:,j))' * l2(:,j);
end

end



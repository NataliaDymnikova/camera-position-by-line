function eqi = generate_instances_for_eq_abcd_simplier( cfg, eq, known, unknown )

prime = cfg.prime;

t1 = randi(10,3,1);
t3 = randi(10,3,1);

flag = true;
while flag
    [R] = get_r_with_prime_abcd_simplier(prime);
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

syms r11 r12 r13 r21 r22 r23 real;
R2 = get_r_abcd_simplier(r11, r12, r13, r21, r22, r23);

for j = 1:3
    eqi(j) = cross(R2*l3(:,j), R2'*l1(:,j))' * l2(:,j);
end
eqi(4) = [r11; r12; r13]' * [r21; r22; r23];
eqi(5) = [r11; r12; r13]' * [r11; r12; r13] - 1;
eqi(6) = [r21; r22; r23]' * [r21; r22; r23] - 1;

end

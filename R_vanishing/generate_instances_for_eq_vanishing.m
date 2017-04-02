function eqi = generate_instances_for_eq_vanishing( cfg, eq, known, unknown )

prime = cfg.prime;

[R1] = get_r_with_prime_vanishing(prime);
[R3] = get_r_with_prime_vanishing(prime);

t1 = R1(3,:);
t3 = R3(3,:);

for i = 1:6
    s = randi(100,3,1);
    e = randi(100,3,1);

    camera2s(:,i) = mod(s(1:2)*inverse(s(3), prime), prime);
    camera2e(:,i) = mod(e(1:2)*inverse(e(3), prime), prime);
    
    temp = mod(R1 * s + t1, prime);
    camera1s(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
    temp = mod(R1 * e + t1, prime);
    camera1e(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);

    temp = mod(R3 * s + t3, prime);
    camera3s(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
    temp = mod(R3 * e + t3, prime);
    camera3e(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
end

l1 = mod(get_lines_from_camera(camera1s, camera1e), prime);
l2 = mod(get_lines_from_camera(camera2s, camera2e), prime);
l3 = mod(get_lines_from_camera(camera3s, camera3e), prime);

syms r11 r12 r13 r21 r22 r23 real;
R1 = get_r_vanishing(t1(1),t1(2),t1(3), r11,r12,r13);
R3 = get_r_vanishing(t3(1),t3(2),t3(3), r21,r22,r23);

for j = 1:4
    eqi(j) = mod(cross(mod(R3'*l3(:,j),prime), mod(R1'*l1(:,j),prime))' * l2(:,j),prime);
end
eqi(5) = mod(det(R1),prime - 1);
eqi(6) = mod(det(R3),prime - 1);
end



function eqi = generate_instances_for_eq_small( cfg, eq, known, unknown )

prime = cfg.prime;

t1 = randi(10,3,1);
t3 = randi(10,3,1);

[R1] = get_r_with_prime_small(prime);
[R3] = get_r_with_prime_small(prime);

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
R1 = get_r_small(r11,r12,r13);
R3 = get_r_small(r21,r22,r23);

for j = 1:6
    eqi(j) = mod(cross(mod(R3'*l3(:,j),prime), mod(R1'*l1(:,j),prime))' * l2(:,j),prime);
end

end



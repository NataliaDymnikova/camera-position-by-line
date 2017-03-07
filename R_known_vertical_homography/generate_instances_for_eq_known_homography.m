function eqi = generate_instances_for_eq_known_homography( cfg, eq, known, unknown )

prime = 32999;

[H,a,b,d,tx,ty,nx,ny,nz ] = get_h_with_prime_known_homography(prime);

for i = 1:7
    s = randi(100,3,1);
    e = randi(100,3,1);

    camera2s(:,i) = mod(s(1:2)*inverse(s(3), prime), prime);
    camera2e(:,i) = mod(e(1:2)*inverse(e(3), prime), prime);
    
    temp = mod(H*s, prime);
    camera1s(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
    temp = mod(H*e, prime);
    camera1e(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);

    temp = mod(H'*s, prime);
    camera3s(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);
    temp = mod(H'*e, prime);
    camera3e(:,i) = mod(temp(1:2)*inverse(temp(3), prime), prime);

end

l1 = mod(get_lines_from_camera(camera1s, camera1e), prime);
l2 = mod(get_lines_from_camera(camera2s, camera2e), prime);
l3 = mod(get_lines_from_camera(camera3s, camera3e), prime);

syms a b d tx ty nx ny nz real;
H2 = get_h_known_homography(a,b,d,tx,ty,nx,ny,nz);

eqi(1) = a^2+b^2-1;    
eqi(2) = nx^2 + ny^2 + nz^2 - 1;

    for i=1:7
        eqi(i+2) = cross(l1(:,i), H2*l3(:,i))' * l2(:,i);
    end

end



function [ H ] = get_h_known_homography(a,b,d,nx,ny,nz,tx,ty)

H = [a, -b, 0; b, a, 0; 0, 0, 1] - d * [tx; ty; 1] * [nx, ny, nz];

end


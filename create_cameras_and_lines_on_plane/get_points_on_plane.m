function [start_point, end_point, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points_on_plane(R1,R2, R3,t1,t2,t3, nlevel, nlines)

camera1s = cell(length(nlevel),1);
camera1e = cell(length(nlevel),1);
camera2s = cell(length(nlevel),1);
camera2e = cell(length(nlevel),1);
camera3s = cell(length(nlevel),1);
camera3e = cell(length(nlevel),1);

start_point = zeros(3, nlines);
end_point = zeros(3, nlines);

for j = 1:length(nlevel)
    camera1s{j} = zeros(2, nlines);
    camera1e{j} = zeros(2, nlines);
    camera2s{j} = zeros(2, nlines);
    camera2e{j} = zeros(2, nlines);
    camera3s{j} = zeros(2, nlines);
    camera3e{j} = zeros(2, nlines);
end;

% plane Ax+By+Cz+D=0:
A = randi(100);
B = randi(100);
C = randi([A+B, 2*(A+B)],1,1);
D = randi([-2*(C-A-B), 2*(C-A-B)],1,1);

for lineInd = 1:nlines
    sx = rand(1,1) - 2;
    sy = rand(1,1) - 2;
    sz = -(D+A*sx+B*sy)/C;
    s = [sx;sy;sz];
    
    ex = rand(1,1) + 1;
    ey = rand(1,1) + 1;
    ez = -(D+A*ex+B*ey)/C;
    e = [ex;ey;ez];
    
    start_point(:,lineInd) = s;
    end_point(:,lineInd) = e;

    for j = 1:length(nlevel)
        noize = nlevel(j);
        
        temp = R1 * s + t1;
        camera1s{j}(:,lineInd) = temp(1:2)/temp(3) + randn(2,1) *  noize;
        temp = R1 * e + t1;
        camera1e{j}(:,lineInd) = temp(1:2)/temp(3) + randn(2,1) *  noize;

        temp = R2*s + t2;        
        camera2s{j}(:,lineInd) = temp(1:2)/temp(3) + randn(2,1) *  noize;
        temp = R2*e + t2;      
        camera2e{j}(:,lineInd) = temp(1:2)/temp(3) + randn(2,1) *  noize;

        temp = R3 * s + t3;
        camera3s{j}(:,lineInd) = temp(1:2)/temp(3) + randn(2,1) *  noize;
        temp = R3 * e + t3;
        camera3e{j}(:,lineInd) = temp(1:2)/temp(3) + randn(2,1) *  noize;
    end
end
end
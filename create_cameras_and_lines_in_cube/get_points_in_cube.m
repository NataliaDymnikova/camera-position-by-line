function [start_point, end_point, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points_in_cube(R1,R2, R3,t1,t2,t3,fpix, nlevel, nlines)

camera1s = cell(2, nlines, length(nlevel));
camera1e = cell(2, nlines, length(nlevel));
camera2s = cell(2, nlines, length(nlevel));
camera2e = cell(2, nlines, length(nlevel));
camera3s = cell(2, nlines, length(nlevel));
camera3e = cell(2, nlines, length(nlevel));

start_point = zeros(3, nlines);
end_point = zeros(3, nlines);

for lineInd = 1:nlines
    s = rand(3,1) - 2;
    e = rand(3,1) + 1;

    start_point(:,lineInd) = s;
    end_point(:,lineInd) = e;

    for j = 1:length(nlevel)
        noize = nlevel(j);

        temp = R1 * s + t1;
        camera1s{j}(:,lineInd) = fpix * temp(1:2)/temp(3) + rand(2,1) *  noize;
        temp = R1 * e + t1;
        camera1e{j}(:,lineInd) = fpix * temp(1:2)/temp(3)+ rand(2,1) *  noize;

        temp = R2*s + t2;        
        camera2s{j}(:,lineInd) = fpix * temp(1:2)/temp(3) + rand(2,1) *  noize;
        temp = R2*e + t2;      
        camera2e{j}(:,lineInd) = fpix * temp(1:2)/temp(3) + rand(2,1) *  noize;

        temp = R3 * s + t3;
        camera3s{j}(:,lineInd) = fpix * temp(1:2)/temp(3) + rand(2,1) *  noize;
        temp = R3 * e + t3;
        camera3e{j}(:,lineInd) = fpix * temp(1:2)/temp(3) + rand(2,1) *  noize;
    end
end
end
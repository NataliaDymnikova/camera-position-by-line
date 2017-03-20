function [start_point, end_point, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points_in_cube(R1,R2, R3,t1,t2,t3,fpix, nlevel, nlines)
camera1s = cell(1, length(nlevel));
camera1e = cell(1, length(nlevel));
camera2s = cell(1, length(nlevel));
camera2e = cell(1, length(nlevel));
camera3s = cell(1, length(nlevel));
camera3e = cell(1, length(nlevel));

start_point = zeros(3, nlines);
end_point = zeros(3, nlines);

for j = 1:length(nlevel)
    noize = nlevel(j);
    camera1s{j} = zeros(2, nlines);
    camera1e{j} = zeros(2, nlines);
    camera2s{j} = zeros(2, nlines);
    camera2e{j} = zeros(2, nlines);
    camera3s{j} = zeros(2, nlines);
    camera3e{j} = zeros(2, nlines);

    for lineInd = 1:nlines
        s = rand(3,1) * 4 - 2;
        e = rand(3,1) * 4 - 2;
        
        start_point(:,lineInd) = s;
        end_point(:,lineInd) = e;

        temp = R1 * s + t1;
        camera1s{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
        temp = R1 * e + t1;
        camera1e{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;

        temp = R2*s + t2;        
        camera2s{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
        temp = R2*e + t2;      
        camera2e{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;

        temp = R3 * s + t3;
        camera3s{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
        temp = R3 * e + t3;
        camera3e{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
    end
end

end
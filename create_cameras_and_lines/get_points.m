function [start_point, end_point, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points(R, t1,t3,fpix, nlevel, nlines,width,height)
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
        %s = points(:, lineInd);    
        %e = points(:, lineInd + nlines);
    
        s = [randi(width); randi(height); randi(100)];
        e = [randi(width); randi(height); randi(100)];
        
        camera2s{j}(:,lineInd) = s(1:2)/s(3)*fpix + randn(2,1) *  noize;
        camera2e{j}(:,lineInd) = e(1:2)/e(3)*fpix + randn(2,1) *  noize;

        start_point(:,lineInd) = s;
        end_point(:,lineInd) = e;

        temp = R * s + t1;
        camera1s{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
        temp = R * e + t1;
        camera1e{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;

        temp = R' * s + t3;
        camera3s{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
        temp = R' * e + t3;
        camera3e{j}(:,lineInd) = temp(1:2)/temp(3)*fpix + randn(2,1) *  noize;
        %if (projects_to_image(camera1s, width, height) ...
        %            && projects_to_image(camera2e, width, height) ...
        %            && projects_to_image(camera3s, width, height))
        %        i = i + 1;
        %end

    end
end

end
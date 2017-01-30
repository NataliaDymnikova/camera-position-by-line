function [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines( )

%focal length in pixels
fpix = 1;
%varying noise level
nlevel = [0:0.5:4];
noize = 4;
%number of lines
nlines = 10;
% camera's parameters
width= 640;
height= 480;       

%rotation matrix
a = randn();
b = randn();
c = randn();
d = randn();
n = sqrt (a^2 + b^2 + c^2 + d^2);
R = get_r_abcd(a/n, b/n, c/n, d/n);
%Rs = [R', diag([1,1,1]), R];
        
camera1s = cell(1, length(nlevel));
camera1e = cell(1, length(nlevel));
camera2s = cell(1, length(nlevel));
camera2e = cell(1, length(nlevel));
camera3s = cell(1, length(nlevel));
camera3e = cell(1, length(nlevel));

start_point = zeros(3, nlines);
end_point = zeros(3, nlines);

points = zeros(3, 2*nlines);

t1 = randn(3,1);
t2 = zeros(3,1);
t3 = randn(3,1);

n = 0;
k = 0;
for lineInd = 1:2*nlines
    gend = 0;
    while (~gend)
        s = [xrand(1,1,[-2 2]); xrand(1,1,[-2 2]); xrand(1,1,[4 8])]; 
        
        temp1 = R * s + t1;
        temp3 = R' * s + t3;
        if (projects_to_image(s(1:2)/s(3)*fpix + randn(2,1) * noize, width, height) ...
                && projects_to_image(temp1(1:2)/temp1(3)*fpix + randn(2,1) *  noize, width, height) ...
                && projects_to_image(temp3(1:2)/temp3(3)*fpix + randn(2,1) *  noize, width, height))
            points(:, lineInd) = s;
            gend = 1;
        end
        
        n = n + 1;
        if (n > 1000)
            a = randn();
            b = randn();
            c = randn();
            d = randn();
            n = sqrt (a^2 + b^2 + c^2 + d^2);
            R = get_r_abcd(a/n, b/n, c/n, d/n);

            lineInd = 1;
            n = 0;
            k = k + 1;
        end
    end
end

%i = 0;
for j = 1:length(nlevel)
    noize = nlevel(j);
    camera1s{j} = zeros(2, nlines);
    camera1e{j} = zeros(2, nlines);
    camera2s{j} = zeros(2, nlines);
    camera2e{j} = zeros(2, nlines);
    camera3s{j} = zeros(2, nlines);
    camera3e{j} = zeros(2, nlines);

    for lineInd = 1:nlines
        s = points(:, lineInd);    
        e = points(:, lineInd + nlines);

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

start_points = points(:, 1:nlines);
end_points = points(:, nlines:nlines*2);

end
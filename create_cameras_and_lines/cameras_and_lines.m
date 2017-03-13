function [R, t1, t2, t3, start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = cameras_and_lines( get_r )

%focal length in pixels
fpix = 1;
%varying noise level
nlevel = [0];
noize = 4;
%number of lines
nlines = 3;
% camera's parameters
width= 640;
height= 480;       

%rotation matrix 
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%R = r_abcd();
%R = r_cgr();
R = eval(get_r);
if size(R,3) == 1
    R(:,:,2) = R';
end

points = zeros(3, 2*nlines);

t1 = randi(100,3,1);
t2 = zeros(3,1);
t3 = randi(100,3,1);
% 
% n = 0;
% k = 0;
% for lineInd = 1:2*nlines
%     gend = 0;
%     while (~gend)
%         s = [randi(width * 100); randi(height * 100); randi(100)]; 
%         
%         temp1 = R * s + t1;
%         temp3 = R' * s + t3;
%         if (projects_to_image(s(1:2)/s(3)*fpix + randn(2,1) * noize, width, height) ...
%                 && projects_to_image(temp1(1:2)/temp1(3)*fpix + randn(2,1) *  noize, width, height) ...
%                 && projects_to_image(temp3(1:2)/temp3(3)*fpix + randn(2,1) *  noize, width, height))
%             points(:, lineInd) = s;
%             gend = 1;
%         end
%         
%         n = n + 1;
%         if (n > 1000)
%             a = randi(100);
%             b = randi(100);
%             c = randi(100);
%             d = randi(100);
%             n = sqrt (a^2 + b^2 + c^2 + d^2);
%             R = get_r_abcd(a/n, b/n, c/n, d/n);
% 
%             lineInd = 1;
%             n = 0;
%             k = k + 1;
%         end
%     end
% end
% 
% %i = 0;

[start_points, end_points, camera1s, camera1e, camera2s, camera2e, camera3s, camera3e] = get_points(R, t1,t3,fpix, nlevel, nlines, width,height);
end


function [ R ] = r_abcd()
    a = randi(100);
    b = randi(100);
    c = randi(100);
    d = randi(100);
    n = sqrt (a^2 + b^2 + c^2 + d^2);
    R = get_r_abcd(a/n, b/n, c/n, d/n);
end

function [ R ] = r_cgr()
    s1 = randi(100);
    s2 = randi(100);
    s3 = randi(100);

    s = 1 + s1^2 + s2^2 + s3^2;
    R = get_r_cgr(s1,s2,s3) / s;
end


function [ R ] = r_known_cs()
    c = rand(1);
    s = (2*randi(2) - 3) * sqrt(1 - c^2);
    R = [c,s,0; -s,c,0; 0,0,1];
end

function [ R ] = r_known_cs_diff_r() 
    R(:,:,1)  = r_known_cs();
    R(:,:,2) = r_known_cs();
end
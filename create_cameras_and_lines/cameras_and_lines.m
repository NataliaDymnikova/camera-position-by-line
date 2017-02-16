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
a = randi(100);
b = randi(100);
c = randi(100);
d = randi(100);
n = sqrt (a^2 + b^2 + c^2 + d^2);
R = get_r_abcd(a/n, b/n, c/n, d/n);
%Rs = [R', diag([1,1,1]), R];
R = get_r_with_prime(997);        

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


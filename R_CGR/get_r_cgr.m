function [ R ] = get_r_cgr(s1, s2, s3)
 s = [s1, s2, s3];
 st = s';
 R  = (1-s*st) * eye(3) + 2 * [0, -s3, s2; s3, 0, -s1; -s2, s1, 0] + 2*st*s;
%R = [1-2*s2^2-2*s3^2, 2*(s1*s2-s3), 2*(s1*s3+s2);
%    2*(s1*s2+s3), 1-2*s1^2-2*s3^2, 2*(s3*s2-s1);
%    2*(s1*s3-s2), 2*(s3*s2+s1), 1-2*s1^2-2*s2^2];

end


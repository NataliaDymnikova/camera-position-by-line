function [ R ] = r_cgr( )
s1 = rand();
s2 = rand();
s3 = rand();

s = [s1, s2, s3];
st = s';
R  = (1-s*st) * eye(3) + 2 * [0, -s3, s2; s3, 0, -s1; -s2, s1, 0] + 2*st*s;
R = R / (s1^2+s2^2+s3^2+1);
end


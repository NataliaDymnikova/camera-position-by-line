function [ ls ] = lines(n)

syms a b c d s;
s = a^2 + b^2 + c^2 + d^2;

syms t11 t12 t13 t21 t22 t23 t31 t32 t33;
syms k;

ts = [[t11 t12 t13]' [t21 t22 t23]' [t31 t32 t33]'];
R = 1/s * [[a^2 + b^2 - c^2 - d^2, 2*b*c - 2*a*d, 2*b*d + 2*a*c];
            [2*b*c + 2*a*d, a^2 - b^2 + c^2 - d^2, 2*c*d - 2*a*b];
            [2*b*d - 2*a*c, 2*c*d + 2*a*b, a^2 - b^2 - c^2 + d^2]];

Rs = [R', diag([1,1,1]), R];

for i = 1:n
    x1 = randn;
    y1 = randn;
    z1 = randn;
    
    x2 = randn;
    y2 = randn;
    z2 = randn;

    for j = 1:3
        point_1 = Rs(j) * [x1, y1, z1]' + ts(j);
        point_2 = Rs(j) * [x2, y2, z2]' + ts(j);
    
        ls{i}{j} = point_1 + k * (point_2 - point_1);
    end
end

end


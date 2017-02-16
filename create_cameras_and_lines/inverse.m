function x = inverse(a, p)
    [g, x, y] = gcd(a, p);        
    x = mod(x, p);
end

function [eq, known, unknown, kngroups, cfg, algB] = two_equations()

% symbolic variables
syms a0 a1 a2 b0 b1 b2;
syms x y;

% two equations representing an circle and a hyperbola
eq(1) = (x - a0)^2 + (y - a1)^2 - a2^2;
eq(2) = (x - b0)^2 - (y - b1)^2 - b2^2;

% known parameters
known = {'a0' 'a1' 'a2' 'b0' 'b1' 'b2'};

%two unknowns
unknown = {'x' 'y'};

%no kngroups
kngroups = [];

%config file
cfg = gbs_InitConfig();

%we do not have precomputed algB
algB = [];

end


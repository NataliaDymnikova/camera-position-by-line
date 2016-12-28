% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [x, y] = solver_two_equations(a0, a1, a2, b0, b1, b2)

	% precalculate polynomial equations coefficients
	c(1) = 1;
	c(2) = 1;
	c(3) = -2*a1;
	c(4) = -2*a0;
	c(5) = a0^2 + a1^2 - a2^2;
	c(6) = -1;
	c(7) = 1;
	c(8) = 2*b1;
	c(9) = -2*b0;
	c(10) = b0^2 - b1^2 - b2^2;

	M1 = zeros(2, 5);
	M1(3) = c(1);
	M1(1) = c(2);
	M1(7) = c(3);
	M1(5) = c(4);
	M1(9) = c(5);
	M1(4) = c(6);
	M1(2) = c(7);
	M1(8) = c(8);
	M1(6) = c(9);
	M1(10) = c(10);

	M1 = rref(M1);

	M = zeros(3, 7);
	M(2:3, [2 4 5 6 7]) = M1([1 2], [1 2 3 4 5]);
	M([1]) = M1(1);
	M([7]) = M1(5);
	M([10]) = M1(7);
	M([16]) = M1(9);
	M = rref(M);

	A = zeros(4);
	amcols = [7 6 5 3];
	A(1, 3) = 1;
	A(2, 4) = 1;
	A(3, :) = -M(2, amcols);
	A(4, :) = -M(1, amcols);

	[V D] = eig(A);
	sol =  V([3, 2],:)./(ones(2, 1)*V(1,:));

	if (find(isnan(sol(:))) > 0)
		
		x = zeros(1, 0);
		y = zeros(1, 0);
	else
		
		I = find(not(imag( sol(1,:) )));
		x = sol(1,I);
		y = sol(2,I);
	end
end

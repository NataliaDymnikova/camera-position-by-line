% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [c, s] = solver_get_r_equations_known_cs_bad(l1_11, l2_11, l3_11)

	% precalculate polynomial equations coefficients
	c(1) = 1;
	c(2) = 1;
	c(3) = -1;
	c(4) = l1_11(1)*l2_11(3)*l3_11(2) - l1_11(2)*l2_11(3)*l3_11(1);
	c(5) = l1_11(2)*l2_11(3)*l3_11(1) - l1_11(1)*l2_11(3)*l3_11(2);
	c(6) = 2*l1_11(1)*l2_11(3)*l3_11(1) + 2*l1_11(2)*l2_11(3)*l3_11(2);
	c(7) = - l1_11(1)*l2_11(1)*l3_11(3) - l1_11(3)*l2_11(1)*l3_11(1) - l1_11(2)*l2_11(2)*l3_11(3) - l1_11(3)*l2_11(2)*l3_11(2);
	c(8) = l1_11(1)*l2_11(2)*l3_11(3) - l1_11(2)*l2_11(1)*l3_11(3) + l1_11(3)*l2_11(1)*l3_11(2) - l1_11(3)*l2_11(2)*l3_11(1);

	M1 = zeros(2, 6);
	M1(5) = c(1);
	M1(1) = c(2);
	M1(11) = c(3);
	M1(6) = c(4);
	M1(2) = c(5);
	M1(4) = c(6);
	M1(10) = c(7);
	M1(8) = c(8);

	M1 = rref(M1);

	M = zeros(5, 9);
	M(4:5, [4 5 6 7 8 9]) = M1([1 2], [1 2 3 4 5 6]);
	M([1]) = M1(1);
	M([2 8]) = M1(4);
	M([11]) = M1(5);
	M([7 13]) = M1(6);
	M([17 23]) = M1(8);
	M([22 28]) = M1(10);
	M([36]) = M1(11);
	M([32 38]) = M1(12);
	M = rref(M);

	A = zeros(4);
	amcols = [9 8 7 6];
	A(1, 3) = 1;
	A(2, :) = -M(5, amcols);
	A(3, :) = -M(4, amcols);
	A(4, :) = -M(2, amcols);

	[V D] = eig(A);
	sol =  V([3, 2],:)./(ones(2, 1)*V(1,:));

	if (find(isnan(sol(:))) > 0)
		
		c = zeros(1, 0);
		s = zeros(1, 0);
	else
		
		I = find(not(imag( sol(1,:) )));
		c = sol(1,I);
		s = sol(2,I);
	end
end

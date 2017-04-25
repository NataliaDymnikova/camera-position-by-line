% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [t11, t12, t13, t31, t32, t33] = solver_create_eq_find_t(r1_11, r3_11, l1_11, l2_11, l3_11)

	% precalculate polynomial equations coefficients
	c(1) = l1_11(1)*l3_11(3)*r1_11(1) + l1_11(2)*l3_11(3)*r1_11(2) + l1_11(3)*l3_11(3)*r1_11(3);
	c(2) = l1_11(1)*l3_11(2)*r1_11(1) + l1_11(2)*l3_11(2)*r1_11(2) + l1_11(3)*l3_11(2)*r1_11(3);
	c(3) = l1_11(1)*l3_11(1)*r1_11(1) + l1_11(2)*l3_11(1)*r1_11(2) + l1_11(3)*l3_11(1)*r1_11(3);
	c(4) = - l1_11(3)*l3_11(1)*r3_11(1) - l1_11(3)*l3_11(2)*r3_11(2) - l1_11(3)*l3_11(3)*r3_11(3);
	c(5) = - l1_11(2)*l3_11(1)*r3_11(1) - l1_11(2)*l3_11(2)*r3_11(2) - l1_11(2)*l3_11(3)*r3_11(3);
	c(6) = - l1_11(1)*l3_11(1)*r3_11(1) - l1_11(1)*l3_11(2)*r3_11(2) - l1_11(1)*l3_11(3)*r3_11(3);
	c(7) = -l2_11(1);
	c(8) = l1_11(1)*l3_11(3)*r1_11(4) + l1_11(2)*l3_11(3)*r1_11(5) + l1_11(3)*l3_11(3)*r1_11(6);
	c(9) = l1_11(1)*l3_11(2)*r1_11(4) + l1_11(2)*l3_11(2)*r1_11(5) + l1_11(3)*l3_11(2)*r1_11(6);
	c(10) = l1_11(1)*l3_11(1)*r1_11(4) + l1_11(2)*l3_11(1)*r1_11(5) + l1_11(3)*l3_11(1)*r1_11(6);
	c(11) = - l1_11(3)*l3_11(1)*r3_11(4) - l1_11(3)*l3_11(2)*r3_11(5) - l1_11(3)*l3_11(3)*r3_11(6);
	c(12) = - l1_11(2)*l3_11(1)*r3_11(4) - l1_11(2)*l3_11(2)*r3_11(5) - l1_11(2)*l3_11(3)*r3_11(6);
	c(13) = - l1_11(1)*l3_11(1)*r3_11(4) - l1_11(1)*l3_11(2)*r3_11(5) - l1_11(1)*l3_11(3)*r3_11(6);
	c(14) = -l2_11(2);
	c(15) = l1_11(4)*l3_11(6)*r1_11(1) + l1_11(5)*l3_11(6)*r1_11(2) + l1_11(6)*l3_11(6)*r1_11(3);
	c(16) = l1_11(4)*l3_11(5)*r1_11(1) + l1_11(5)*l3_11(5)*r1_11(2) + l1_11(6)*l3_11(5)*r1_11(3);
	c(17) = l1_11(4)*l3_11(4)*r1_11(1) + l1_11(5)*l3_11(4)*r1_11(2) + l1_11(6)*l3_11(4)*r1_11(3);
	c(18) = - l1_11(6)*l3_11(4)*r3_11(1) - l1_11(6)*l3_11(5)*r3_11(2) - l1_11(6)*l3_11(6)*r3_11(3);
	c(19) = - l1_11(5)*l3_11(4)*r3_11(1) - l1_11(5)*l3_11(5)*r3_11(2) - l1_11(5)*l3_11(6)*r3_11(3);
	c(20) = - l1_11(4)*l3_11(4)*r3_11(1) - l1_11(4)*l3_11(5)*r3_11(2) - l1_11(4)*l3_11(6)*r3_11(3);
	c(21) = -l2_11(4);
	c(22) = l1_11(4)*l3_11(6)*r1_11(4) + l1_11(5)*l3_11(6)*r1_11(5) + l1_11(6)*l3_11(6)*r1_11(6);
	c(23) = l1_11(4)*l3_11(5)*r1_11(4) + l1_11(5)*l3_11(5)*r1_11(5) + l1_11(6)*l3_11(5)*r1_11(6);
	c(24) = l1_11(4)*l3_11(4)*r1_11(4) + l1_11(5)*l3_11(4)*r1_11(5) + l1_11(6)*l3_11(4)*r1_11(6);
	c(25) = - l1_11(6)*l3_11(4)*r3_11(4) - l1_11(6)*l3_11(5)*r3_11(5) - l1_11(6)*l3_11(6)*r3_11(6);
	c(26) = - l1_11(5)*l3_11(4)*r3_11(4) - l1_11(5)*l3_11(5)*r3_11(5) - l1_11(5)*l3_11(6)*r3_11(6);
	c(27) = - l1_11(4)*l3_11(4)*r3_11(4) - l1_11(4)*l3_11(5)*r3_11(5) - l1_11(4)*l3_11(6)*r3_11(6);
	c(28) = -l2_11(5);
	c(29) = l1_11(7)*l3_11(9)*r1_11(1) + l1_11(8)*l3_11(9)*r1_11(2) + l1_11(9)*l3_11(9)*r1_11(3);
	c(30) = l1_11(7)*l3_11(8)*r1_11(1) + l1_11(8)*l3_11(8)*r1_11(2) + l1_11(9)*l3_11(8)*r1_11(3);
	c(31) = l1_11(7)*l3_11(7)*r1_11(1) + l1_11(8)*l3_11(7)*r1_11(2) + l1_11(9)*l3_11(7)*r1_11(3);
	c(32) = - l1_11(9)*l3_11(7)*r3_11(1) - l1_11(9)*l3_11(8)*r3_11(2) - l1_11(9)*l3_11(9)*r3_11(3);
	c(33) = - l1_11(8)*l3_11(7)*r3_11(1) - l1_11(8)*l3_11(8)*r3_11(2) - l1_11(8)*l3_11(9)*r3_11(3);
	c(34) = - l1_11(7)*l3_11(7)*r3_11(1) - l1_11(7)*l3_11(8)*r3_11(2) - l1_11(7)*l3_11(9)*r3_11(3);
	c(35) = -l2_11(7);
	c(36) = l1_11(7)*l3_11(9)*r1_11(4) + l1_11(8)*l3_11(9)*r1_11(5) + l1_11(9)*l3_11(9)*r1_11(6);
	c(37) = l1_11(7)*l3_11(8)*r1_11(4) + l1_11(8)*l3_11(8)*r1_11(5) + l1_11(9)*l3_11(8)*r1_11(6);
	c(38) = l1_11(7)*l3_11(7)*r1_11(4) + l1_11(8)*l3_11(7)*r1_11(5) + l1_11(9)*l3_11(7)*r1_11(6);
	c(39) = - l1_11(9)*l3_11(7)*r3_11(4) - l1_11(9)*l3_11(8)*r3_11(5) - l1_11(9)*l3_11(9)*r3_11(6);
	c(40) = - l1_11(8)*l3_11(7)*r3_11(4) - l1_11(8)*l3_11(8)*r3_11(5) - l1_11(8)*l3_11(9)*r3_11(6);
	c(41) = - l1_11(7)*l3_11(7)*r3_11(4) - l1_11(7)*l3_11(8)*r3_11(5) - l1_11(7)*l3_11(9)*r3_11(6);
	c(42) = -l2_11(8);

	M = zeros(6, 7);
	M(31) = c(1);
	M(25) = c(2);
	M(19) = c(3);
	M(13) = c(4);
	M(7) = c(5);
	M(1) = c(6);
	M(37) = c(7);
	M(32) = c(8);
	M(26) = c(9);
	M(20) = c(10);
	M(14) = c(11);
	M(8) = c(12);
	M(2) = c(13);
	M(38) = c(14);
	M(33) = c(15);
	M(27) = c(16);
	M(21) = c(17);
	M(15) = c(18);
	M(9) = c(19);
	M(3) = c(20);
	M(39) = c(21);
	M(34) = c(22);
	M(28) = c(23);
	M(22) = c(24);
	M(16) = c(25);
	M(10) = c(26);
	M(4) = c(27);
	M(40) = c(28);
	M(35) = c(29);
	M(29) = c(30);
	M(23) = c(31);
	M(17) = c(32);
	M(11) = c(33);
	M(5) = c(34);
	M(41) = c(35);
	M(36) = c(36);
	M(30) = c(37);
	M(24) = c(38);
	M(18) = c(39);
	M(12) = c(40);
	M(6) = c(41);
	M(42) = c(42);

	M = rref(M);

	A = zeros(1);
	amcols = [7];
	A(1, :) = -M(1, amcols);

	[V D] = eig(A);
	sol =  V([],:)./(ones(0, 1)*V(1,:));

	if (find(isnan(sol(:))) > 0)
		
		t11 = zeros(1, 0);
		t12 = zeros(1, 0);
		t13 = zeros(1, 0);
		t31 = zeros(1, 0);
		t32 = zeros(1, 0);
		t33 = zeros(1, 0);
	else
		
		%WARNING: cannot extract all unknowns at once. A back-substitution required (not implemented/automatized)
		ev  = diag(D);
		I = find(not(imag( sol(1,:) )) & not(imag( ev )));
		t11 = ev(I);
		%WARNING: one or more unknowns could not be extracted.
		%WARNING: one or more unknowns could not be extracted.
		%WARNING: one or more unknowns could not be extracted.
		%WARNING: one or more unknowns could not be extracted.
		%WARNING: one or more unknowns could not be extracted.
	end
end

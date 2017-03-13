% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [s2, c2, s1, c1] = solver_get_r_equations_known_cs_diff_r(l1_11, l2_11, l3_11)

	% precalculate polynomial equations coefficients
	c(1) = 1;
	c(2) = 1;
	c(3) = -1;
	c(4) = 1;
	c(5) = 1;
	c(6) = -1;
	c(7) = l1_11(2)*l2_11(3)*l3_11(1) - l1_11(1)*l2_11(3)*l3_11(2);
	c(8) = l1_11(1)*l2_11(3)*l3_11(1) + l1_11(2)*l2_11(3)*l3_11(2);
	c(9) = - l1_11(1)*l2_11(3)*l3_11(1) - l1_11(2)*l2_11(3)*l3_11(2);
	c(10) = l1_11(2)*l2_11(3)*l3_11(1) - l1_11(1)*l2_11(3)*l3_11(2);
	c(11) = l1_11(3)*l2_11(1)*l3_11(1) + l1_11(3)*l2_11(2)*l3_11(2);
	c(12) = - l1_11(1)*l2_11(1)*l3_11(3) - l1_11(2)*l2_11(2)*l3_11(3);
	c(13) = l1_11(3)*l2_11(1)*l3_11(2) - l1_11(3)*l2_11(2)*l3_11(1);
	c(14) = l1_11(1)*l2_11(2)*l3_11(3) - l1_11(2)*l2_11(1)*l3_11(3);
	c(15) = l1_11(5)*l2_11(6)*l3_11(4) - l1_11(4)*l2_11(6)*l3_11(5);
	c(16) = l1_11(4)*l2_11(6)*l3_11(4) + l1_11(5)*l2_11(6)*l3_11(5);
	c(17) = - l1_11(4)*l2_11(6)*l3_11(4) - l1_11(5)*l2_11(6)*l3_11(5);
	c(18) = l1_11(5)*l2_11(6)*l3_11(4) - l1_11(4)*l2_11(6)*l3_11(5);
	c(19) = l1_11(6)*l2_11(4)*l3_11(4) + l1_11(6)*l2_11(5)*l3_11(5);
	c(20) = - l1_11(4)*l2_11(4)*l3_11(6) - l1_11(5)*l2_11(5)*l3_11(6);
	c(21) = l1_11(6)*l2_11(4)*l3_11(5) - l1_11(6)*l2_11(5)*l3_11(4);
	c(22) = l1_11(4)*l2_11(5)*l3_11(6) - l1_11(5)*l2_11(4)*l3_11(6);

	M1 = zeros(4, 13);
	M1(17) = c(1);
	M1(29) = c(2);
	M1(49) = c(3);
	M1(2) = c(4);
	M1(6) = c(5);
	M1(50) = c(6);
	M1(11) = c(7);
	M1(15) = c(8);
	M1(23) = c(9);
	M1(27) = c(10);
	M1(35) = c(11);
	M1(43) = c(12);
	M1(39) = c(13);
	M1(47) = c(14);
	M1(12) = c(15);
	M1(16) = c(16);
	M1(24) = c(17);
	M1(28) = c(18);
	M1(36) = c(19);
	M1(44) = c(20);
	M1(40) = c(21);
	M1(48) = c(22);

	M1 = rref(M1);

	M2 = zeros(20, 35);
	M2(17:20, [21 23 24 25 26 27 28 30 31 32 33 34 35]) = M1(1:4, :);
	M2([1 22 83 204]) = M1(1);
	M2([41 62 123 244]) = M1(5);
	M2([85 106 147 268]) = M1(10);
	M2([109 130 171 292]) = M1(15);
	M2([153 174 195 316]) = M1(20);
	M2([209 230 271 332]) = M1(23);
	M2([225 246 287 348]) = M1(26);
	M2([333 354 375 396]) = M1(32);
	M2([405 426 467 528]) = M1(34);
	M2([409 430 471 532]) = M1(35);
	M2([425 446 487 548]) = M1(38);
	M2([429 450 491 552]) = M1(39);
	M2([465 486 507 568]) = M1(42);
	M2([469 490 511 572]) = M1(43);
	M2([525 546 567 588]) = M1(46);
	M2([529 550 571 592]) = M1(47);
	M2([601 622 643 664]) = M1(49);
	M2([613 634 655 676]) = M1(52);
	M2 = rref(M2);

	M = zeros(19, 25);
	M(8:19, [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]) = M2([5 10 11 12 13 14 15 16 17 18 19 20], [7 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35]);
	M([1 40]) = M2(455);
	M([22]) = M2(539);
	M([23 43 82 140]) = M2(560);
	M([96 154]) = M2(575);
	M([79]) = M2(579);
	M([61 81 101 159]) = M2(580);
	M([153 173]) = M2(595);
	M([136]) = M2(599);
	M([118 138 158 178]) = M2(600);
	M([248 306]) = M2(615);
	M([212]) = M2(619);
	M([194 214 253 311]) = M2(620);
	M([267 325]) = M2(635);
	M([231]) = M2(639);
	M([213 233 272 330]) = M2(640);
	M([286 344]) = M2(655);
	M([269]) = M2(659);
	M([251 271 291 349]) = M2(660);
	M([343 363]) = M2(675);
	M([326]) = M2(679);
	M([308 328 348 368]) = M2(680);
	M([419 439]) = M2(695);
	M([402]) = M2(699);
	M([384 404 424 444]) = M2(700);
	M = rref(M);

	A = zeros(6);
	amcols = [25 24 23 22 21 20];
	A(1, 5) = 1;
	A(2, :) = -M(17, amcols);
	A(3, :) = -M(14, amcols);
	A(4, :) = -M(12, amcols);
	A(5, :) = -M(11, amcols);
	A(6, :) = -M(7, amcols);

	[V D] = eig(A);
	sol =  V([5, 4, 3, 2],:)./(ones(4, 1)*V(1,:));

	if (find(isnan(sol(:))) > 0)
		
		s2 = zeros(1, 0);
		c2 = zeros(1, 0);
		s1 = zeros(1, 0);
		c1 = zeros(1, 0);
	else
		
		I = find(not(imag( sol(1,:) )));
		s2 = sol(1,I);
		c2 = sol(2,I);
		s1 = sol(3,I);
		c1 = sol(4,I);
	end
end

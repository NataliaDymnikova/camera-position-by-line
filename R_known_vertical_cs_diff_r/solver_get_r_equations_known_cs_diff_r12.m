% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [s1, c2, s2, c1] = solver_get_r_equations_known_cs_diff_r(l1_11, l2_11, l3_11)

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
	M1(1) = c(1);
	M1(29) = c(2);
	M1(49) = c(3);
	M1(18) = c(4);
	M1(10) = c(5);
	M1(50) = c(6);
	M1(15) = c(7);
	M1(7) = c(8);
	M1(27) = c(9);
	M1(23) = c(10);
	M1(43) = c(11);
	M1(35) = c(12);
	M1(39) = c(13);
	M1(47) = c(14);
	M1(16) = c(15);
	M1(8) = c(16);
	M1(28) = c(17);
	M1(24) = c(18);
	M1(44) = c(19);
	M1(36) = c(20);
	M1(40) = c(21);
	M1(48) = c(22);

	M1 = rref(M1);

	M2 = zeros(20, 35);
	M2(17:20, [21 22 23 24 26 28 29 30 31 32 33 34 35]) = M1(1:4, :);
	M2([1 22 83 204]) = M1(1);
	M2([25 46 107 228]) = M1(6);
	M2([49 70 131 252]) = M1(11);
	M2([93 114 155 276]) = M1(16);
	M2([149 170 191 312]) = M1(19);
	M2([233 254 295 356]) = M1(24);
	M2([265 286 307 368]) = M1(26);
	M2([321 342 363 384]) = M1(29);
	M2([405 426 467 528]) = M1(34);
	M2([413 434 475 536]) = M1(36);
	M2([425 446 487 548]) = M1(38);
	M2([433 454 495 556]) = M1(40);
	M2([465 486 507 568]) = M1(42);
	M2([473 494 515 576]) = M1(44);
	M2([525 546 567 588]) = M1(46);
	M2([533 554 575 596]) = M1(48);
	M2([601 622 643 664]) = M1(49);
	M2([609 630 651 672]) = M1(51);
	M2 = rref(M2);

	M = zeros(19, 25);
	M(8:19, [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25]) = M2([8 10 11 12 13 14 15 16 17 18 19 20], [8 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35]);
	M([1 97]) = M2(518);
	M([60]) = M2(539);
	M([23 43 82 140]) = M2(560);
	M([58 154]) = M2(578);
	M([98]) = M2(579);
	M([61 81 101 159]) = M2(580);
	M([115 173]) = M2(598);
	M([155]) = M2(599);
	M([118 138 158 178]) = M2(600);
	M([191 306]) = M2(618);
	M([250]) = M2(619);
	M([194 214 253 311]) = M2(620);
	M([210 325]) = M2(638);
	M([269]) = M2(639);
	M([213 233 272 330]) = M2(640);
	M([248 344]) = M2(658);
	M([288]) = M2(659);
	M([251 271 291 349]) = M2(660);
	M([305 363]) = M2(678);
	M([345]) = M2(679);
	M([308 328 348 368]) = M2(680);
	M([381 439]) = M2(698);
	M([421]) = M2(699);
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
		
		s1 = zeros(1, 0);
		c2 = zeros(1, 0);
		s2 = zeros(1, 0);
		c1 = zeros(1, 0);
	else
		
		I = find(not(imag( sol(1,:) )));
		s1 = sol(1,I);
		c2 = sol(2,I);
		s2 = sol(3,I);
		c1 = sol(4,I);
	end
end
function [ R_err, t_err ] = test( R_original, t_original, R_test, t_test )

[index_best, y] = choose_best_solution(R_test, t_test, R_original, t_original);
R_err = y(1);
t_err = y(2);

end


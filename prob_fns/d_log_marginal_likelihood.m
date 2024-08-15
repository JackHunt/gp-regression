function J = d_log_marginal_likelihood(K, Y, J_K)
%D_LOG_MARGINAL_LIKELIHOOD Derivative of LML of a GP
    alpha = cholsolve(K, Y);
    aTa = alpha * alpha';

    J = [];
    for i = 1 : size(J_K, 1)
        J_K2 = cell2mat(J_K(i));
        J = [J; 0.5 * trace(aTa * J_K2 - cholsolve(K, J_K2))];
    end
end


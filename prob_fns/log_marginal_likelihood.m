function ln_p = log_marginal_likelihood(K, Y)
%LOG_MARGINAL_LIKELIHOOD LML of a GP
    L = jitter_chol(K);
    n = size(Y, 1);
    det_K = sum(diag(L));
    ln_p = -0.5 * (Y' * (L' \ (L \ Y)) + det_K + n * log(2 * pi));
end

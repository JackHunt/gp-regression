function d_ln_p = d_log_marginal_likelihood(K, Y, d_K)
%D_LOG_MARGINAL_LIKELIHOOD Derivative of LML of a GP
    alpha = compute_alpha(K, Y);
    d_ln_p = 0.5 * trace(alpha * alpha' * d_K - compute_alpha(K, d_K));
end


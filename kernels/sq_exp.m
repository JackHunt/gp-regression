function K = sq_exp(X, K, theta)
%SQ_EXP Squared Exponential Kernel.
    sigma = theta(1);
    lambda = theta(2);
    sigma_2 = theta(3);

    r = pdist2(X, K);
        
    K = sigma^2 * exp((-r.^2 / (2 * lambda^2)));

    K = K + sigma_2^2 * eye(size(K));
end

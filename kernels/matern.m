function K = matern(X, K, theta, type)
%MATERN Function implementing the 3/2 and 5/2 matern kernels.
%   Function parameter used to select kernel. Default is 3/2.
    sigma = theta(1);
    lambda = theta(2);
    sigma_2 = theta(3);

    r = pdist2(X, K);

    if strcmp(type, '3o2')
        v = sqrt(3) * r / lambda;
        K = sigma^2 * (v + 1) .* exp(-v);
    elseif strcmp(type, '5o2')
        v = sqrt(5) * r / lambda;
        K = sigma^2 * (1 + v + 5 * r.^2 / 3 * lambda^2) .* exp(-v);
    else
        error("Unknown matern kernel type.")
    end

    n = sigma_2^2 * eye(size(K));
    K = K + n;
end
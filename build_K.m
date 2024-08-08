function K = build_K(M, M2, theta, kernel)
%GETCOV Returns the covarince matrix of 2 given matrices.
    m = size(M, 1);
    n = size(M2, 1);

    M_rep = repmat(M(:, 1), 1, n);
    M2_rep = repmat(M2(:, 1)', m, 1);

    if strcmp(kernel, 'sqExp')
        K = sq_exp(M_rep, M2_rep, theta, '');
    elseif strcmp(kernel, '1o2')
        K = matern(M_rep, M2_rep, theta(1), theta(2), '1o2');
    elseif strcmp(kernel, '3o2')
        K = matern(M_rep, M2_rep, theta(1), theta(2), '3o2');
    else
        error('Unknown kernel type.');
    end
end
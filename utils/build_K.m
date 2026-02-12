function K = build_K(M, M2, theta, kernel)
%GETCOV Returns the covarince matrix between 2 given matrices.
    if strcmp(kernel, 'sqExp')
        K = sq_exp(M, M2, theta);
    elseif strcmp(kernel, '3o2')
        K = matern(M, M2, theta, '3o2');
    elseif strcmp(kernel, '3o2prod')
        K = matern_product(M, M2, theta, '3o2');
    elseif strcmp(kernel, '5o2prod')
        K = matern_product(M, M2, theta, '5o2');
    elseif strcmp(kernel, '5o2')
        K = matern(M, M2, theta, '5o2');
    else
        error('Unknown kernel type.');
    end
end
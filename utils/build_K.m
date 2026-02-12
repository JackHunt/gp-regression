function K = build_K(M, M2, theta, kernel, jacobian)
%GETCOV Returns the covarince matrix between 2 given matrices.
    arguments
        M;
        M2;
        theta;
        kernel;
        jacobian = false;
    end

    if strcmp(kernel, 'sqExp')
        K = sq_exp(M, M2, theta, jacobian);
    elseif strcmp(kernel, '3o2')
        K = matern(M, M2, theta, '3o2', jacobian);
    elseif strcmp(kernel, '5o2')
        K = matern(M, M2, theta, '5o2', jacobian);
    else
        error('Unknown kernel type.');
    end
end
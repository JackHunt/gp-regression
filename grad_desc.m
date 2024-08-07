function theta = gradDesc(X, Y, K, alpha, theta, theta_labels, kernel, jitter)
%GRADDESC Performs gradient descent to optimize the hyperparameters, theta.
% Order of theta hyperparameters: [lambda, sigma] - linespace, variance.
    % Make it safe to invert K.
    K = make_pos_def(K);
    epoch = 0;
    for iter = 1 : 15
        epoch = epoch + 1;
        K_inv = pinv(K);
        beta = alpha * alpha' - K_inv;
        K_tmp = zeros(size(K));
        
        % For each parameter, generate a K for the corresponding derivative.
        for param = 1 : size(theta, 1)
            for elem = 1 : size(X, 1)
                for elem2 = 1 : size(X, 1)
                    if strcmp(kernel, 'sqExp')
                        K_tmp(elem, elem2) = sq_exp(X(elem, 1), X(elem2, 1), ...
                                                theta, theta_labels(1, param));
                    elseif strcmp(kernel, '1o2')
                        K_tmp(elem, elem2) = matern(X(elem, 1), X(elem2, 1), ...
                                                theta, '1o2', theta_labels(1, param));
                    elseif strcmp(kernel, '3o2')
                        K_tmp(elem, elem2) = matern(X(elem, 1), X(elem2, 1), ...
                                                theta, '3o2', theta_labels(1, param));
                    else
                        error('UNKNOWN KERNEL')
                    end
                end
            end
            trace(beta * K_tmp);
            theta(param, 1) = theta(param, 1) - (0.7 * (0.5 * trace(beta * K_tmp)));
        end
        
        K = build_K(X, X, theta, kernel);
        K = make_pos_def(K);
        %L = chol(K+(eye(size(K))*jitter));
        L = jitter_chol(K);
        alpha = L' \ (L \ Y);
    end
end
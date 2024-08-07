function K = build_K(M, M2, theta, kernel)
%GETCOV Returns the covarince matrix of 2 given matrices.
    for i = 1 : size(M, 1)
        for j = 1 : size(M2, 1)
            if strcmp(kernel, 'sqExp')%Squared exponential.
                K(i, j) = sqExp(M(i, 1), M2(j, 1), theta, '');
            elseif strcmp(kernel, '1o2')
                K(i, j) = matern(M(i, 1), M2(j, 1), theta(1), theta(2), '1o2');
            elseif strcmp(kernel, '3o2')
                K(i, j) = matern(M(i, 1), M2(j, 1), theta(1), theta(2), '3o2');
            end
        end
    end
end
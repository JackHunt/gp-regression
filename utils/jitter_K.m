function K = jitter_K(K, jitter)
%JITTER_K Add jitter to a cov matrix diagonal.
    arguments
        K;
        jitter = 4;
    end

    K = K + eye(size(K)) * jitter;
end


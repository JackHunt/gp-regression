function L = jitter_chol(K)
    jitter = 1e-8;
    L = 0;
    while true
        if (jitter > 100000)
            sprintf("jitter_chol failed. Returning identity.")
            L = eye(size(K));
            break
        end
        
        try
            L = chol(K + jitter * eye(size(K)), "lower");
            break
        catch ME
            jitter = jitter * 2;
        end
    end
end
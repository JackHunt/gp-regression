function L = jitter_chol(K)
    passed = false;
    jitter = 1e-8;
    L = 0;
    while ~passed
        if (jitter > 100000)
            L = chol(eye(size(K)));
            break
        end
        
        try
            L = chol(K + jitter * eye(size(K)));
            passed = true;
        catch ME
            jitter = jitter * 1.1;
            passed = false;
        end
    end
end
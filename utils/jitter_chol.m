function L = jitter_chol(K)
    passed = false;
    jitter = 1e-8;% * mean(diag(K));
    L = 0;
    while ~passed
        if (jitter > 100000)
            jitter
            error('jitter_chol failed.');
            break
        end
        
        try
            L = chol(K + jitter * eye(size(K)));
            passed = true;
        catch ME
            jitter = jitter * 2;
            passed = false;
        end
    end
end
function M2 = make_pos_def(M)
%MAKEPOSDEF Takes a matrix and makes it positive definite. 
    [eig_vec, eig_val] = eig(M);
    diag_eig_val = diag(eig_val);

    min_val = min(diag_eig_val);
    tol = 1e-10;

    diag_eig_val(diag_eig_val < tol) = ...
        diag_eig_val(diag_eig_val < tol) + 2 * abs(min_val);
    
    diag_eig_val(diag_eig_val > tol & diag_eig_val < 1e-5) = ...
        diag_eig_val(diag_eig_val > tol & diag_eig_val < 1e-5) + abs(min_val);

    eig_val = diag(diag_eig_val);
    M2 = eig_vec * eig_val * eig_vec';
end


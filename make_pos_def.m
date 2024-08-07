function M2 = make_pos_def(M)
%MAKEPOSDEF Takes a matrix and makes it positive definite. 
    [eig_val eig_vec] = eig(M);
    minVal = min(diag(eig_vec));
    
    for elem = 1 : size(eig_vec, 1)
        if eig_vec(elem, elem) < 10^-10
            eig_vec(elem, elem) = eig_vec(elem, elem) + 2 * abs(minVal);
        else
            if eig_vec(elem, elem) > 10^-10 && eig_vec(elem, elem) < 0.00001
                eig_vec(elem, elem) = eig_vec(elem, elem) + abs(minVal);
            end
        end
    end
    
    M2 = eig_val * eig_vec * eig_val';
end


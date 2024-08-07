function M2 = make_pos_def(M)
%MAKEPOSDEF Takes a matrix and makes it positive definite. 
    [eigVal eigVec] = eig(M);
    minVal = min(diag(eigVec));
    
    for elem = 1 : size(eigVec, 1)
        if eigVec(elem, elem) < 10^-10
            eigVec(elem, elem) = eigVec(elem, elem)+2*abs(minVal);
        else
            if eigVec(elem, elem) > 10^-10 && eigVec(elem, elem) < 0.00001
                eigVec(elem, elem) = eigVec(elem, elem) + abs(minVal);
            end
        end
    end
    
    M2 = eigVal * eigVec * eigVal';
end


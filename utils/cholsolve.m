function [alpha, L] = cholsolve(A, B)
%CHOLSOLVE Solve via chol, of course...
    L = jitter_chol(A);
    alpha = L' \ (L \ B);
end


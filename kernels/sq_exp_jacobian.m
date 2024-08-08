function J = sq_exp_jacobian(x1, x2, theta)
%SQ_EXP_JACOBIAN Squared Exponential Kernel Jacobian.
    lambda = theta(1);
    sigma = theta(2);
    
    sq_diff = (x1 - x2).^2;

    d_l = (sigma.^2 * sq_diff * exp(-sq_diff) / 2 * lambda.^2) / lambda.^3;
    d_s = 2 * sigma * exp(-sq_diff / (2 * lambda.^2));

    J = [d_l, d_s];
end
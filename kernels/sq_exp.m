function y = sq_exp(X, Y, theta, jacobian)
%SQ_EXP Squared Exponential Kernel.
    arguments
        X;
        Y;
        theta;
        jacobian = false;
    end

    if jacobian
        y = sq_exp_jac(X, Y, theta);
    else
        sigma = theta(1);
        lambda = theta(2);
        r = pdist2(X, Y);
        
        y = sigma^2 * exp((-r.^2 / (2 * lambda^2)));
    end
end

function J = sq_exp_jac(X, Y, theta)
%SQ_EXP_JACOBIAN Squared Exponential Kernel Jacobian.
    lambda = theta(1);
    sigma = theta(2);
    r = pdist2(X, Y);
    
    d_l = (r.^2 * sigma^2 * exp((-r.^2 / (2 * lambda^2)))) / lambda^3;
    d_s = 2 * sigma * exp((-r.^2 / (2 * lambda^2)));

    J = {d_l; d_s};
end
function y = sq_exp(x1, x2, theta, jacobian)
%SQ_EXP Squared Exponential Kernel.
    arguments
        x1;
        x2;
        theta;
        jacobian = false;
    end

    if jacobian
        y = sq_exp_jacobian(x1, x2, theta);
    else
        y = (theta(2)^2) * exp(-((x1 - x2).^2) / (2 * theta(1)^2));
    end
end
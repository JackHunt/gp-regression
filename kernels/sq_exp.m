function y = sq_exp(x1, x2, theta, deriv)
%SQ_EXP Squared Exponential Kernel.
    if (strcmp('sigma', deriv))
        y = d_sigma(x1, x2, theta(1), theta(2));
    elseif (strcmp('lambda', deriv))
        y = d_lambda(x1, x2, theta(1), theta(2));
    else
        y = (theta(2)^2) * exp(-((x1 - x2)^2) / (2 * theta(1)^2));
    end
end

function y = d_sigma(x1, x2, lambda, sigma)
%D_SIG Partial derivative w.r.t sigma.
    y = (2 * sigma) * exp(-((x1 - x2)^2) / (2 * lambda^2));
end

function y = d_lambda(x1, x2, lambda, sigma)
%D_LAMBDA Partial derivative w.r.t lambda.
    y = ((sigma^2 * (x1 - x2)^2) * exp(-((x1 - x2)^2)) / 2 * lambda^2) / lambda^3;
end
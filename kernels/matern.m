function Y = matern(X, Y, theta, type, jacobian)
%MATERN Function implementing the 3/2 and 5/2 matern kernels.
%   Function parameter used to select kernel. Default is 3/2.
    arguments
        X;
        Y;
        theta;
        type = '3o2';
        jacobian = false;
    end

    if jacobian
        Y = matern_jac(X, Y, theta, type);
    else
        sigma = theta(1);
        lambda = theta(2);

        r = pdist2(X, Y);

        if strcmp(type, '3o2')
            v = sqrt(3) * r / lambda;
            Y = sigma^2 * exp(-v) * (v + 1);
        elseif strcmp(type, '5o2')
            v = sqrt(5) * r / lambda;
            Y = sigma^2 * exp(-v) * ((5 * lambda^2 * r.^2) / 3 + v + 1);
        else
            error("Unknown matern kernel type.")
        end
    end
end

function J = matern_jac(M1, M2, theta, type)
%MATERN_JACOBIAN Jacobian of the matern kernel.
%   Function parameter used to select kernel.
    sigma = theta(1);
    lambda = theta(2);

    r = pdist2(M1, M2);

    if strcmp(type, '3o2')
        r_sq_5 = r.^2;
        
        d_l = (3 * r_sq_5 * sigma^2 * ...
            exp((-(sqrt(3) * r) / lambda))) / lambda^3;
        
        v = sqrt(3) * r / lambda;
        d_s = 2 * sigma * exp((-v)) * (v + 1);
        
        J = {d_s; d_l};
    elseif strcmp(type, '5o2')
        r_sq_5 = 5 * r.^2;
        v = sqrt(5) * r / lambda;
        
        d_l = (r_sq_5 * sigma^2 * exp(-v) * ...
            (2 * lambda^4 + sqrt(5) * r * lambda^3 + 3)) / (3 * lambda^3);
        
        d_s = 2 * sigma * exp(-v) * ((lambda^2 * r_sq_5) / 3 + v + 1);

        J = {d_s; d_l};
    else
        error("Unknown matern kernel type.")
    end
end
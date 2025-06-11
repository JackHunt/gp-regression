function y = matern(x1, x2, theta, type, jacobian)
%MATERN Function imlpementing the 1/2 and 3/2 matern kernels.
%   Function parameter used to select kernel. Default is 3/2.
    arguments
        x1;
        x2;
        theta;
        type = '3o2';
        jacobian = false;
    end

    if jacobian
        y = matern_jacobian(x1, x2, theta, type);
    else
        lambda = theta(1);
        omega = theta(2);

        if strcmp(type, '3o2')
            y = lambda^2 * (1 + sqrt(3) * ((x1 - x2) / omega)) ...
                .* exp(-sqrt(3) * ((x1 - x2) / omega));
        elseif strcmp(type, '1o2')
            y = lambda^2 * exp(-(x1 - x2) / omega);
        else
            error("Unknown matern kernel type.")
        end
    end
end


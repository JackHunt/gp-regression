function y = matern(x1, x2, lambda, omega, type)
%MATERN Function imlpementing the 1/2 and 3/2 matern kernels.
%   Function parameter used to select kernel. Default is 1/2.
    if strcmp(type, '3o2')
        y = (lambda.^2) * (1 + sqrt(3) * ((x1 - x2) / omega)) * exp(-sqrt(3) * ((x1 - x2) / (omega)));
    else
        y = (lambda.^2) * exp(-(x1 - x2) / (omega));
    end
end


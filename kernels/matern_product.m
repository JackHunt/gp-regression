function Y = matern_product(X, Y, theta, type)
%MATERN_PRODUCT Summary of this function goes here
%   Detailed explanation goes here
    sigma1 = theta(1);
    lambda1 = theta(2);
    
    sigma2 = theta(3);
    lambda2 = theta(4);

    Y = matern(X, Y, [sigma1 lambda1], type) + matern(X, Y, [sigma2 lambda2], type);
end
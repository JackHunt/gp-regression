function J = matern_jacobian(x1, x2, theta, type)
%MATERN_JACOBIAN Jacobian of the matern kernel.
%   Function parameter used to select kernel.
    lambda = theta(1);
    omega = theta(2);
    sq_diff = (x1 - x2).^2;
    if strcmp(type, '3o2')
        d_l = (exp(-sq_diff / 2 * lambda^2)) * omega^2 * sq_diff / lambda^3;
        d_o = 2 * exp(-sq_diff / 2 * lambda^2) * omega;

        J = {d_l; d_o};
    elseif strcmp(type, '1o2')
        y = lambda^2 * exp(-(x1 - x2) / omega);
    else
        error("Unknown matern kernel type.")
    end
end


function [theta_opt, lml] = optimise_lml(X, Y, theta_init, kernel)
%OPTIMISE_LML Optimize the log marginal likelihood w.r.t hyperparameters.
    options = optimoptions('fminunc', ...
        'Algorithm','trust-region', ...
        'SpecifyObjectiveGradient', true, ...
        'Display', 'iter', ...
        'PlotFcn', 'optimplotfval');

    f = @(theta) combined_objective(X, Y, theta, kernel);

    [theta_opt, lml] = fminunc(f, theta_init, options);
end

function [lml, J] = combined_objective(X, Y, theta, kernel)
    K = build_K(X, Y, theta, kernel);
    lml = -log_marginal_likelihood(K, Y);

    J_K = build_K(X, Y, theta, kernel, true);
    J = d_log_marginal_likelihood(K, Y, J_K);
end
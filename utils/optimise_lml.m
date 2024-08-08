function [theta_opt, lml] = optimise_lml(X, Y, theta_init, kernel)
%OPTIMISE_LML Optimize the hyperparameters.
    options = optimoptions('fminunc', ...
        'Algorithm', 'trust-region', ...
        'SpecifyObjectiveGradient', true);

    theta = theta_init;

    f = @(theta) combined_objective(X, Y, theta, kernel);

    % Perform optimization
    [theta_opt, lml] = fminunc(f, theta0, options);
end

function [lml, d_lml] = combined_objective(X, Y, theta, kernel)
    % Build K
    % lml

    % Build gradk
    % grad lml
end
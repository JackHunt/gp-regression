%% Setup and load data.
Setup;
OPTIMISE = true;

[X, Y, X_s, Y_s] = get_sotonmet();

%% Hyperparameters.
%kernel = 'sqExp';
kernel = '3o2';
%theta = [1.0 1.0]';
theta = [1.0 1.0]';
%theta_labels = {'lambda' 'sigma'};
theta_labels = {'lambda' 'omega'};

%% GP Regression
% Optimise hyperparams
if OPTIMISE
    [theta, lml_theta] = optimise_lml(X, Y, theta, kernel);
    fprintf('Log Marginal Likelihood (theta): %d\n', lml_theta);
end

% Calculate covariance matrices.
K = build_K(X, X, theta, kernel);
K = jitter_K(K);
K_s = build_K(X, X_s, theta, kernel);
K_ss = build_K(X_s, X_s, theta, kernel);

% Get the cholesky decomposition of K and solve for alpha.
[alpha, L] = cholsolve(K, Y);

% Solve.
f_s = K_s' * alpha; % f star.
v = L \ K_s;
V_s = K_ss - v' * v; % V star. Accompanying variances.
V_s = make_pos_def(V_s);

MSE = mean((Y_s - f_s).^2);
fprintf('MSE: %d\n', MSE);

lml_K = log_marginal_likelihood(K, Y);
fprintf('Log Marginal Likelihood: %d\n', lml_K);

%% Plot.
close all;
two_sd = 2 * sqrt(diag(V_s));
f_s_sd = [f_s + two_sd; flipdim(f_s - two_sd, 1)];
figure;
fill([X_s; flipdim(X_s, 1)], f_s_sd, [7 7 7] / 8,  'DisplayName', '+/- 2SD');

hold on;
plot(X_s, f_s, 'DisplayName', 'Prediction');
plot(X_s, Y_s, 'DisplayName', 'Ground Truth');
legend;
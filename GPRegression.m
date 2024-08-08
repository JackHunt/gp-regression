%% Setup and load data.
Setup;
OPTIMISE = false;

[X, Y, X_s, Y_s] = get_sotonmet();

%% Hyperparameters.
kernel = 'sqExp';
theta = [0.075 0.6]';
theta_labels = {'lambda' 'sigma'};

%% GP Regression
if OPTIMISE
    K_tmp = build_K(X, X, theta, kernel);
    L = jitter_chol(K_tmp);
    alpha = L' \ (L \ Y);
    [theta, nll] = optimise_lml(X, Y, K_tmp, alpha, theta, theta_labels, kernel);
    clear K_tmp L alpha;
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

LML = log_marginal_likelihood(K, Y);
fprintf('Log Marginal Likelihood: %d\n', LML);

%% Plot.
close all;
f_s_SD = [f_s + 2 * sqrt(diag(V_s)); flipdim(f_s - 2 * sqrt(diag(V_s)), 1)];
figure;
fill([X_s; flipdim(X_s, 1)], f_s_SD, [7 7 7] / 8,  'DisplayName', '+/- 2SD');

hold on;
plot(X_s, f_s, 'DisplayName', 'Prediction');
plot(X_s, Y_s, 'DisplayName', 'Ground Truth');
legend;
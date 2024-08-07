%% Initialize environment and read file.
clear all;
close all;
clc;
addpath('kernels');
ReadFile; %(MATLAB generated script, reads to cell array).   

%% Config.
TO_KEEP = [3]; % Features to keep.
X_COL = 3;
Y_COL = 6;
LABEL_COL = 11;
OPTIMISE = false;

%% Hyperparameter initial values and names).
kernel = 'sqExp';
theta = [0.075 0.6]'; % sqExp;
theta_labels = {'lambda' 'sigma'}; % lengthscale and variance.
jitter = 4;

%% Clean, transform and arrange data.
for row = 1 : size(sotonmet, 1)
    sotonmet{row, 1} = datenum(sotonmet{row, 1},'yyyy-mm-ddTHH:MM:SS');
    sotonmet{row, 3} = datenum(sotonmet{row, 3},'yyyy-mm-ddTHH:MM:SS');
end

sotonmet = cell2mat(sotonmet);


%% Separate data points with missing features.
to_delete = [];
X_s = [];
for row = 1 : size(sotonmet,1)
    for col = 1 : size(sotonmet, 2)
        if isnan(sotonmet(row, col))
            X_s = [X_s; sotonmet(row, :)];
            to_delete = [to_delete; row];
            break
        end
    end
end

sotonmet(to_delete, :) = [];
X = sotonmet;
Y = X(:, Y_COL);
X = X(:, TO_KEEP);
Y_s_truth = X_s(:, LABEL_COL);
X_s = X_s(:, TO_KEEP);

clear to_delete sotonmet col row TO_KEEP;

% Subtract first date from all dates.
X = X - X(1,1);
X_s = X_s - X_s(1,1);

%% GP Regression
if OPTIMISE
    K_tmp = build_k(X, X, theta, kernel);
    %L = chol(K_tmp + (eye(size(K_tmp)) * jitter));
    L = jitter_chol(K_tmp);
    alpha = L'\(L\Y);
    theta = grad_desc(X, Y, K_tmp, alpha, theta, theta_labels, kernel, jitter); % TODO: replace
    clear K_tmp L alpha;
end

% Calculate covariance matrices.
K = build_K(X, X, theta, kernel);
K = K + eye(size(K)) * jitter;
K_s = build_K(X, X_s, theta, kernel);
K_ss = build_K(X_s, X_s, theta, kernel);

% Get the cholesky decomposition of K and solve for alpha.
%L = chol(K);
L = jitter_chol(K);
alpha = L' \ (L \ Y);

% Solve for solutions.
f_s = K_s' * alpha; % f star.
v = L \ K_s;
V_s = K_ss - v' * v; % V star. Accompanying variances.
V_s = make_pos_def(V_s);

MSE = mean((Y_s_truth - f_s).^2);
fprintf('MSE: %d\n', MSE);

%% Plots.
close all;
f_s_SD = [f_s + 2 * sqrt(diag(V_s)); flipdim(f_s - 2 * sqrt(diag(V_s)), 1)];
figure;
fill([X_s; flipdim(X_s, 1)], f_s_SD, [7 7 7]/8,  'DisplayName', '+/- 2SD');
hold on;
plot(X_s, f_s, 'DisplayName', 'Prediction');
plot(X_s, Y_s_truth, 'DisplayName', 'Ground Truth');
legend('-DynamicLegend', 2);
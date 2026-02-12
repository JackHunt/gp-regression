function [X, Y, X_s, Y_s] = get_sotonmet(pred_percent)
%GET_SOTONMET Summary of this function goes here
    arguments
        pred_percent = 0.2;
    end

    TO_KEEP = [3]; % Column ids to keep.
    Y_COL = 6;

    fname = 'sotonmet.csv';
    sotonmet = readcell(fname);
    sotonmet = sotonmet(2:end, :);

    sotonmet(:, [1, 3]) = cellfun( ...
        @datenum, sotonmet(:, [1, 3]), 'UniformOutput', false);

    % Make dates start at 0
    date_a = cell2mat(sotonmet(:, 1));
    date_b = cell2mat(sotonmet(:, 3));

    sotonmet(:, 1) = num2cell(date_a - min(date_a));
    sotonmet(:, 3) = num2cell(date_b - min(date_b));

    % Remove rows with NaNs
    sotonmet(cellfun(@(x) all(ismissing(x)), sotonmet)) = {NaN};
    nan_rows = any(cellfun(@(x) isnan(x), sotonmet), 2);

    sotonmet(nan_rows, :) = [];

    % Convert remaining cell array to matrix
    X = cell2mat(sotonmet);
    Y = X(:, Y_COL);
    X = X(:, TO_KEEP);

    % Split.
    n_fit = floor(size(X, 1) * (1 - pred_percent));

    X_s = X(n_fit + 1 : size(X, 1), :);
    Y_s = Y(n_fit + 1 : size(Y, 1), :);

    X = X(1 : n_fit, :);
    Y = Y(1 : n_fit, :);
end
function [X, Y, X_s, Y_s] = get_sotonmet()
%GET_SOTONMET Summary of this function goes here
    TO_KEEP = [3]; % Column ids to keep.
    X_COL = 3;
    Y_COL = 6;
    LABEL_COL = 11;

    fname = 'sotonmet.csv';
    sotonmet = readcell(fname);
    sotonmet = sotonmet(2:end, :);

    sotonmet(:, [1, 3]) = cellfun(@datenum, sotonmet(:, [1, 3]), 'UniformOutput', false);

    % Make dates start at 0
    date_a = cell2mat(sotonmet(:, 1));
    date_b = cell2mat(sotonmet(:, 3));

    sotonmet(:, 1) = num2cell(date_a - min(date_a));
    sotonmet(:, 3) = num2cell(date_b - min(date_b));

    sotonmet(cellfun(@(x) all(ismissing(x)), sotonmet)) = {NaN};
    nan_rows = any(cellfun(@(x) isnan(x), sotonmet), 2);
    
    % Extract rows with NaNs
    X_s = sotonmet(nan_rows, :);
    Y_s = cell2mat(X_s(:, LABEL_COL));
    X_s = cell2mat(X_s(:, TO_KEEP));

    % Remove rows with NaNs
    sotonmet(nan_rows, :) = [];

    % Convert remaining cell array to matrix
    X = cell2mat(sotonmet);
    Y = X(:, Y_COL);
    X = X(:, TO_KEEP);


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

    % Subtract first date from all dates
    X = X - X(1,1);
    X_s = X_s - X_s(1,1);


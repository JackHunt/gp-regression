function [X, Y, X_s, Y_s] = get_sotonmet()
%GET_SOTONMET Summary of this function goes here
    TO_KEEP = [3]; % Column ids to keep.
    X_COL = 3;
    Y_COL = 6;
    LABEL_COL = 11;

    fname = 'sotonmet.csv';
    sotonmet = readcell(fname);
    sotonmet = sotonmet(2:end, :);

    for row = 1 : size(sotonmet, 1)
        sotonmet{row, 1} = datenum(sotonmet{row, 1});
        sotonmet{row, 3} = datenum(sotonmet{row, 3});
    end

    sotonmet(cellfun(@(x) all(ismissing(x)), sotonmet)) = {NaN};

    to_delete = [];
    X_s = [];
    for row = 1 : size(sotonmet,1)
        for col = 1 : size(sotonmet, 2)
            if isnan(sotonmet{row, col})
                X_s = [X_s; sotonmet{row, :}];
                to_delete = [to_delete; row];
                break
            end
        end
    end

    sotonmet(to_delete, :) = [];
    X = cell2mat(sotonmet);
    
    Y = X(:, Y_COL);
    X = X(:, TO_KEEP);
    
    Y_s = X_s(:, LABEL_COL);
    X_s = X_s(:, TO_KEEP);

    % Subtract first date from all dates.
    X = X - X(1,1);
    X_s = X_s - X_s(1,1);
end


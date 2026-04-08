% Example data
data = readtable('ResponseVolumeDoE.xlsx');  % Load your data from an Excel file
% Fit the model (for example, a quadratic model with all two-way interactions)
model = fitlm(data, 'quadratic');

% Generate grids for each pair of parameters
params = {'Number_of_Beds', 'Sediment_Volume', 'HemiDep', 'Threshold_Velocity', 'Acceleration_Coefficient'};
numParams = length(params);

for i = 1:numParams
    for j = i+1:numParams
        [P1_grid, P2_grid] = meshgrid(linspace(min(data.(params{i})), max(data.(params{i})), 50), ...
                                      linspace(min(data.(params{j})), max(data.(params{j})), 50));

        % Prepare a table for prediction assuming other parameters are at their median values
        tbl = array2table(repmat(median(data{:, params}), numel(P1_grid), 1), 'VariableNames', params);
        tbl.(params{i}) = P1_grid(:);
        tbl.(params{j}) = P2_grid(:);

        % Predict the response using the fitted model
        Prediction_Grid = predict(model, tbl);
        Prediction_Grid = reshape(Prediction_Grid, size(P1_grid));

        % Plot the response surface
        figure;
        surf(P1_grid, P2_grid, Prediction_Grid, 'EdgeColor', 'none');
        xlabel(params{i});
        ylabel(params{j});
        zlabel('Objective Function');
        title(['Response Surface between ', params{i}, ' and ', params{j}]);
        colorbar;
    end
end

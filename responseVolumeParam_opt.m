% Define array of parameter values
param_values = linspace(100, 600, 10);

% Prepare to collect results
results = [];

% Loop over all parameter values
for idx = 1:numel(param_values)
    % Print current iteration and total number of iterations
    fprintf('Running simulation %d of %d\n', idx, numel(param_values));

    % Current parameter value
    current_param = param_values(idx);
    
    % Calculate the objective function result
    calcError = objectiveFunctionResVol(current_param);
    
    % Store parameter and result
    results = [results; current_param, calcError];
end

% Save results to a .mat file
save('opt_Vel_results.mat', 'results');

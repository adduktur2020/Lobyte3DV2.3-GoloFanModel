function parameterSweepSingleVariable
    % Optimized values for the parameters
    optimizedValues = [16.9721239000686, 96.5608600421476]; %set2
    % optimizedValues = [950000, 7.6011, 46.396];
    % optimizedValues = [10, 950000, 0.0123, 7.6011, 0.5247, 46.396, 0.0170714];
    % paramNames = {'Number of iterations', 'Sediment Volume', 'Hemipelagic Rate', 'Deposition Velocity', ...
    %               'Acceleration Coefficient', 'Flow Thickness', 'Sediment Concentration'}; 
    % 
    % % Define parameter bounds
    % lb = [300, 100000, 0.01, 4, 0.4, 20, 0.01]; % Lower bounds
    % ub = [700, 2000000, 0.04, 20, 0.7, 100, 0.05]; % Upper bounds

    paramNames = {'DepVelS2', 'FlowHeightS2'}; 
    % paramNames = {'SedVolS2', 'Deposition Velocity', 'Flow Height'}; 

    % Define parameter bounds
    lb = [6, 40]; % Lower bounds
    ub = [20, 100]; % Upper bounds

    % Number of points to evaluate for each parameter
    numPoints = 10;

    % Initialize storage for results
    allResults = []; % Each row: [param1, param2, ..., param7, objectiveValue]
    changingResults = []; % Each row: [param1, param2, objectiveValue]

    % Loop over each pair of parameters
    for paramIndex1 = 1:length(optimizedValues)
        for paramIndex2 = paramIndex1+1:length(optimizedValues)
            % Create ranges for the two parameters
            paramRange1 = linspace(lb(paramIndex1), ub(paramIndex1), numPoints);
            paramRange2 = linspace(lb(paramIndex2), ub(paramIndex2), numPoints);

            % Nested loops for the two varying parameters
            for i = 1:numPoints
                for j = 1:numPoints
                    % Start with optimized values
                    currentParams = optimizedValues;
                    % Update the two varying parameters
                    currentParams(paramIndex1) = paramRange1(i);
                    currentParams(paramIndex2) = paramRange2(j);

                    % Calculate the objective value
                    objectiveValue = objectiveFunctionS(currentParams);

                    % Append the result to changingResults
                    changingResults = [changingResults; paramRange1(i), paramRange2(j), objectiveValue]; %#ok<AGROW>
                    
                    % Append the full parameter combination and objective value to allResults
                    allResults = [allResults; currentParams, objectiveValue]; %#ok<AGROW>
                end
            end

            % Save results for the current pair of parameters
            filename = sprintf('Sweep_%s_vs_%s.mat', paramNames{paramIndex1}, paramNames{paramIndex2});
            save(filename, 'changingResults', 'paramNames');

            % Clear temporary results for the next pair
            changingResults = [];
        end
    end

    % Save all combinations of parameters and their objective values
    save('parameterSweepAllCombinations2.mat', 'allResults', 'paramNames');

    disp('Two-variable parameter sweeps completed. Results saved.');
end





% function calcError = objectiveFunction(params)
%     % Update the parameter file with the current parameters
%     filePath = 'modelInputParameters/GoloFanGaRunPlot.txt'; % Define the path to your parameter file
%     updateParameterFileConstant(filePath, params);
% 
%     % Run the model
%     system('lobyte3D modelInputParameters/GoloFanGaRunPlot.txt');
% 
%     % Read the model's output error from the results file
%     calcError = readmatrix('totalError.txt'); % Replace with the actual path if needed
% 
%     % Return the calculated error
%     return;
% end

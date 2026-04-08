function optimizationScript
    numVariables = 7; % Number of parameters to optimize
    paramNames = {'Number of iterations', 'Sediment Volume', 'Hemipelagic Rate', 'Deposition Velocity', 'Acceleration Coefficient', 'Flow Thickness', 'Sediment Concentration'}; 

    % Define parameter bounds
    lb = [100, 10000000, 0.01, 4, 0.4, 10, 0.009]; % Lower bounds
    ub = [500, 50000000, 0.04, 20, 0.7, 100, 0.05]; % Upper bounds

    % Initialize storage for parameter sets and errors
    global paramHistory errorHistory
    paramHistory = []; % To store parameter sets
    errorHistory = []; % To store corresponding objective function values

    % Configure GA options with the output function
    options = optimoptions('ga', ...
    'PopulationSize', 50, ...
    'MaxGenerations', 50, ...
    'Display', 'iter', ...
    'PlotFcn', {@gaplotbestf, @gaplotscores}, ...
    'UseParallel', false, ...
    'OutputFcn', @myOutputFunction);

    % Start the timer
    tic;

    % Run the GA
    [x, fval] = ga(@objectiveFunction, numVariables, [], [], [], [], lb, ub, [], options);

    % Display optimized parameters and function value
    disp('Optimized Parameters:');
    for i = 1:numVariables
        fprintf('%s: %f\n', paramNames{i}, x(i));
    end
    disp('Objective Function Value at Optimized Parameters:');
    disp(fval);

    % Elapsed time
    elapsedTime = toc;
    fprintf('The GA finished in %f seconds.\n', elapsedTime);

    % Save the parameter history and error history to a .mat file for later analysis
    save('GA_ResultsT.mat', 'paramHistory', 'errorHistory', 'paramNames');

    % % Generate a PCA plot for all parameters
    % generatePCAPlot(paramHistory, errorHistory);

    % Generate surface plots for selected pairs of parameters
    generateSurfacePlots(paramHistory, errorHistory, paramNames, lb, ub);
end


function [state, options, optchanged] = myOutputFunction(options, state, flag)
    global paramHistory errorHistory
    optchanged = false; % Initialize flag indicating no changes to options

    switch flag
        case 'iter' % At each iteration
            % Load the existing best score from a file, if the file exists
            fileName = 'bestScore.txt';
            if exist(fileName, 'file') == 2
                fileContents = readmatrix(fileName);
                existingBestScore = fileContents(1); % First line is the best score
            else
                existingBestScore = Inf; % If file doesn't exist, set to Inf
            end
    
            % Get the current best score and parameters from the GA state
            currentBestScore = min(state.Score);
            currentBestIndex = find(state.Score == currentBestScore, 1, 'first');
            currentBestParams = state.Population(currentBestIndex, :);
    
            % Check if the current best score is better than the existing best
            if currentBestScore < existingBestScore
                % Update the file with the new best score and parameters
                writematrix([currentBestScore; currentBestParams'], fileName);
                disp(['New best score found: ', num2str(currentBestScore)]);
            end
            % Store the current population and scores (errors) for this generation
            paramHistory = [paramHistory; state.Population]; % Append current generation's population
            errorHistory = [errorHistory; state.Score]; % Append current generation's error values
    end
end

% Function to generate a PCA plot for the parameter space
function generatePCAPlot(paramHistory, errorHistory)
    % Perform PCA on the parameter history to reduce to 2 components
    [coeff, score, ~, ~, explained] = pca(paramHistory);

    % Select the first two principal components
    PC1 = score(:, 1); % First principal component
    PC2 = score(:, 2); % Second principal component

    % Create the plot with color-coded error values
    figure;
    scatter(PC1, PC2, 50, errorHistory, 'filled'); % Color based on error values
    colorbar; % Show color bar to indicate error magnitude
    xlabel('PC1');
    ylabel('PC2');
    title(sprintf('PCA of Parameters (explained variance: %.2f%%)', sum(explained(1:2))));
    colormap(jet); % Apply color map
end

% Function to generate surface plots from the GA process
function generateSurfacePlots(paramHistory, errorHistory, paramNames, lb, ub)
    % Choose the error threshold for 'best-fit' solutions
    errorThreshold = min(errorHistory) * 1.05; % 5% above the minimum error

    % Filter parameter sets based on the error threshold
    bestFits = paramHistory(errorHistory <= errorThreshold, :);
    bestErrors = errorHistory(errorHistory <= errorThreshold);

    % Generate pairwise surface plots for each combination of parameters
    figure;
    numVars = size(bestFits, 2);
    for i = 1:numVars
        for j = i+1:numVars
            subplot(numVars-1, numVars-1, (i-1)*(numVars-1) + j-1);

            % Create a grid of parameter values for pair (i, j)
            x1_range = linspace(lb(i), ub(i), 10);
            x2_range = linspace(lb(j), ub(j), 10);
            [X1, X2] = meshgrid(x1_range, x2_range);

            % Interpolate the objective function (error) values
            Z = griddata(bestFits(:,i), bestFits(:,j), bestErrors, X1, X2, 'cubic');

            % Plot the surface with color-coded error
            surf(X1, X2, Z, 'EdgeColor', 'none'); % Surface plot without grid lines
            colorbar; % Show color bar to indicate error magnitude
            xlabel(paramNames{i});
            ylabel(paramNames{j});
            zlabel('Error');
            title(sprintf('%s vs %s', paramNames{i}, paramNames{j}));

            % Adjust view for better visualization
            view(2); % Set to 2D view (top-down)
        end
    end
end

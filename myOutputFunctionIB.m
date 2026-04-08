function [state, options, optchanged] = myOutputFunctionIB(options, state, flag)
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
end
end

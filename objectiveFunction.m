function calcError = objectiveFunction(params)

    % global modelError
    % Update the parameter file with the current parameters
    filePath = 'modelInputParameters\GoloFanGaRunSearch.txt'; % Define the path to your parameter file
    updateParameterFileConstant(filePath, params);
    
    % Construct the command to run your model
    % Ensure the path to the lobyte3D executable is correct
    % You might need to provide the absolute path if it's not in MATLAB's current working directory
    % commandStr = sprintf('D:\\Matlab\\GaOpt\\lobyte3D %s', filePath);
    
    % Run the model using the system command
    lobyte3D modelInputParameters/GoloFanGaRunSearch.txt
    
    % After running the model, you need to calculate the error between your model's output
    % and the real data. This step depends on how your model outputs its results
    % and how you can access those results from MATLAB.
    % Here, you'll need to replace the following placeholder with your actual error calculation logic

    calcError = readmatrix('totalError.txt'); % Error calculation logic based on model's output and real data
    
    % Return the calculated error to the GA
    return;
end

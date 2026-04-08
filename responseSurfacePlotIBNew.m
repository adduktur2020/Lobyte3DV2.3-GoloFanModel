% Load the .mat file
load('GA_Results.mat'); % Replace 'your_file_name.mat' with your actual file name

% Combine paramHistory and errorHistory
combinedData = [paramHistory, errorHistory];

% Select two input parameters for the response surface
paramX_index = 1; % Index of the first input parameter (adjust as needed)
paramY_index = 2; % Index of the second input parameter (adjust as needed)
objective_index = size(combinedData, 2); % Index of the objective function

% Extract the relevant columns
X = combinedData(:, paramX_index); % First input parameter
Y = combinedData(:, paramY_index); % Second input parameter
Z = combinedData(:, objective_index); % Objective function values

% Create a grid for the response surface
[Xq, Yq] = meshgrid(linspace(min(X), max(X), 100), linspace(min(Y), max(Y), 100));

% Interpolate objective function values onto the grid
Zq = griddata(X, Y, Z, Xq, Yq, 'cubic');

% Plot the response surface
figure;
surf(Xq, Yq, Zq, 'EdgeColor', 'none'); % Response surface plot
xlabel(['Parameter ', num2str(paramX_index)]);
ylabel(['Parameter ', num2str(paramY_index)]);
zlabel('Objective Function Value');
title('Response Surface');
colorbar; % Show color scale
view(3); % Set 3D view
grid on;

% Save the plot if needed
saveas(gcf, 'response_surface.png');

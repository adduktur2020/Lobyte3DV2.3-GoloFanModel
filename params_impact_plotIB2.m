% % Define the parameters and their total change values
% parameters = {'Threshold Velocity', 'Acceleration Coefficient', 'No Beds/Time Duration', ...
%     'Hemi Depo Rate', 'Sediment Volume', 'Flow Thickness', ...
%     'Basal Friction', 'Sediment Concentration', 'Supply Osc Period', ...
%     'Turbidity Currents Int.', 'Diffusion Coefficient', 'Erosion Rate'};
% 
% totalChange = [0.3688, 0.2174, 0.0303, 0.0256, 0.0209, 0.00918, 0.0061, ...
%     0.0061, 0.0033, 0, 0, 0];
% 
% % Create a bar plot
% figure;
% hold on;
% 
% % Generate a colormap
% colors = lines(length(parameters));
% 
% % Plot each bar separately to ensure each has a unique legend entry
% for i = 1:length(parameters)
%     bar(i, totalChange(i), 'FaceColor', colors(i, :));
% end
% 
% % Add legend
% legend(parameters, 'Location', 'northeastoutside','FontSize',12);
% 
% % Set x-axis and y-axis labels
% xlabel('Parameters');
% ylabel('Total Change in Objective Function');
% 
% % Set x-axis ticks to be empty
% set(gca, 'XTick', []);
% 
% % Add title
% title('Parameter Sensitivity Ranking');
% 
% % Display the plot
% grid on;
% hold off;

% Define the parameters and their total change values
parameters = {'Threshold Velocity', 'Acceleration Coefficient', 'Sediment Volume', ...
    'Flow Thickness', 'Number of Beds/Time Duration', 'Hemipelagic Rate', ...
    'Sediment Concentration', 'Basal Friction', 'Radiation Factor', ...
    'Flow COG', 'Pond height prop.', 'Erosion Rate'};

% Baseline and perturbed OF values
baselineOF = 0.3591;
perturbedOF_plus = [0.7276, 0.57, 0.4778, 0.4713, 0.4486, 0.45552, 0.4625, 0.3618, 0.3609, 0.3591, 0.3591, 0.3591];
perturbedOF_minus = [0.4588, 0.4526, 0.4671, 0.4457, 0.4695, 0.3647, 0.3618, 0.3625, 0.3606, 0.3591, 0.3591, 0.3591];

% Calculate absolute changes
absoluteChanges_plus = abs(perturbedOF_plus - baselineOF);
absoluteChanges_minus = abs(perturbedOF_minus - baselineOF);

% Calculate total change for each parameter
totalChange = absoluteChanges_plus + absoluteChanges_minus;

% Rank parameters based on total change
[sortedTotalChange, sortIdx] = sort(totalChange, 'descend');
sortedParameters = parameters(sortIdx);

% Display the ranking
disp('Ranking of parameters based on impact on the objective function:');
for i = 1:length(sortedParameters)
    fprintf('%d. %s: Total Change = %.4f\n', i, sortedParameters{i}, sortedTotalChange(i));
end

% Create a bar plot
figure;
hold on;

% Generate a colormap
colors = lines(length(parameters));

% Plot each bar separately to ensure each has a unique legend entry
for i = 1:length(sortedParameters)
    bar(i, sortedTotalChange(i), 'FaceColor', colors(i, :));
end

% Add legend
legend(sortedParameters, 'Location', 'northeastoutside','FontSize',15);

% Set x-axis and y-axis labels
xlabel('Parameters');
ylabel('Total Change in Objective Function');

% Set x-axis ticks to be empty
set(gca, 'XTick', []);

% Add title
title('Parameter Sensitivity Ranking');

% Display the plot
grid on;
hold off;

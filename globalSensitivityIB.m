% Define parameter ranges: [min, max] for each parameter
param_ranges = [
    10, 30;   % Time duration/iterations
    1e5, 2e6;  % Sediment volume in each flow
    0.01, 0.04;   % Hemipelagic deposition rate
    1.3e8, 1.3e12 % Erosion rate
    0.03, 0.05 % Basal Friction
    4, 20; % Deposition velocity threshold
    0.1, 0.7;    % Flow acceleration/deceleration coefficient
    20, 100;   % Total flow thickness
    0.01, 0.02 % Flow COG
    1,3 % Pond height
    0.01, 0.05  % Volumetric sediment concentration
];
n_params = size(param_ranges, 1); % Number of parameters

% Number of samples for Sobol analysis
n_samples = 6;

% Generate Sobol samples using the sobolset function
sobol_seq = sobolset(n_params, 'Skip', 100, 'Leap', 100);
sobol_samples = net(sobol_seq, n_samples);

% Scale samples to parameter ranges
scaled_samples = param_ranges(:, 1)' + sobol_samples .* diff(param_ranges, 1, 2)';

% Preallocate results
model_outputs = zeros(n_samples, 1);

% Loop through each sample and run the model
for i = 1:n_samples
    params = scaled_samples(i, :);
    model_outputs(i) = objectiveFunctionGS(params); % Replace with your model function
end

% Split the samples into two independent sets
half = n_samples / 2;
A = scaled_samples(1:half, :);
B = scaled_samples(half+1:end, :);

% Construct AB matrices for cross-effects
AB = zeros(half, n_params, n_params);
for i = 1:n_params
    AB(:, :, i) = B; % Start with B
    AB(:, i, i) = A(:, i); % Replace the i-th column with A's values
end

% Preallocate results
output_A = zeros(half, 1);
output_B = zeros(half, 1);

% Compute outputs for A and B
for i = 1:half
    output_A(i) = objectiveFunction(A(i, :)); % Replace with your model function
    output_B(i) = objectiveFunction(B(i, :));
end

% Preallocate results
output_AB = zeros(half, n_params);

% Compute outputs for AB matrices
for i = 1:n_params
    for j = 1:half
        output_AB(j, i) = objectiveFunction(AB(j, :, i)); % Replace with your model function
    end
end


% Compute mean and variance of outputs
mean_Y = mean([output_A; output_B]);
var_Y = var([output_A; output_B]);

% Compute first-order indices
Si = zeros(n_params, 1);
for i = 1:n_params
    Si(i) = (mean(output_A .* output_AB(:, i)) - mean_Y^2) / var_Y;
end


% Compute total-order indices
STi = zeros(n_params, 1);
for i = 1:n_params
    STi(i) = 1 - (mean(output_B .* output_AB(:, i)) - mean_Y^2) / var_Y;
end


disp('First-order Sobol Indices (Si):');
disp(Si);
disp('Total-order Sobol Indices (STi):');
disp(STi);

% Plot bar chart for Sobol indices
figure;
bar([Si, STi]);
legend('First Order (Si)', 'Total Order (STi)');
xlabel('Parameters');
ylabel('Sobol Index');
title('Sobol Sensitivity Analysis');

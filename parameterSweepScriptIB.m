function parameterSweepScriptIB
    numVariables = 7; % Number of parameters
    paramNames = {'Number of iterations', 'Sediment Volume', 'Hemipelagic Rate', 'Deposition Velocity', ...
                  'Acceleration Coefficient', 'Flow Thickness', 'Sediment Concentration'}; 

    % Define parameter bounds
    lb = [300, 100000, 0.01, 4, 0.1, 20, 0.01]; % Lower bounds
    ub = [700, 2000000, 0.04, 20, 1.0, 100, 0.05]; % Upper bounds

    % Generate parameter values (5 equally spaced points for each parameter)
    numPoints = 6;
    paramGrid = cell(1, numVariables);
    for i = 1:numVariables
        paramGrid{i} = linspace(lb(i), ub(i), numPoints);
    end

    % Initialize storage for results
    totalCombinations = numPoints^numVariables;
    allParams = zeros(totalCombinations, numVariables);
    allErrors = zeros(totalCombinations, 1);

    % Generate all combinations of parameters
    idx = 1;
    for p1 = paramGrid{1}
        for p2 = paramGrid{2}
            for p3 = paramGrid{3}
                for p4 = paramGrid{4}
                    for p5 = paramGrid{5}
                        for p6 = paramGrid{6}
                            for p7 = paramGrid{7}
                                % Store the parameter combination
                                allParams(idx, :) = [p1, p2, p3, p4, p5, p6, p7];
                                
                                % Calculate objective function value
                                allErrors(idx) = objectiveFunction(allParams(idx, :));
                                
                                % Increment index
                                idx = idx + 1;
                            end
                        end
                    end
                end
            end
        end
    end

    % Save results to a .mat file
    save('parameterSweepResults.mat', 'allParams', 'allErrors');

    disp('Parameter sweep completed. Results saved to "parameterSweepResults.mat".');
end



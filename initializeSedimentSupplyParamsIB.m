% function [glob] = initializeSedimentSupplyParamsIB(glob)
% 
%     % Set the starting sediment volume to the maximum volume - High to Low
%     glob.flowSedVolStart = glob.flowSedVolMax;
% 
%     % Calculate the oscillation amplitude (remains the same)
%     glob.flowSedVolOscillationAmplitude = (glob.flowSedVolMax - glob.flowSedVolMin);
% 
%     % Set the period to match the duration, as we want to decrease to zero over the full run
%     % This will ensure that the sine wave starts at +1 and ends at 0
%     glob.flowSedVolOscillationPeriod = glob.maxIts * 2;
% 
%     % Create a time vector
%     t = 1 : glob.maxIts;
% 
%     % Create the flowSedVolHistory that decreases from max to min with no increase
%     glob.flowSedVolHistory(t) = glob.flowSedVolStart * (sin((pi/2) - (t / glob.maxIts) * (pi/2)));
% end



function [glob] = initializeSedimentSupplyParamsIB(glob)

    % Set the starting sediment volume to the minimum volume - Low to High
    glob.flowSedVolStart = glob.flowSedVolMin;

    % Calculate the oscillation amplitude (remains the same)
    glob.flowSedVolOscillationAmplitude = (glob.flowSedVolMax - glob.flowSedVolMin);

    % Create a time vector
    t = 1 : glob.maxIts;

    % Create the flowSedVolHistory that increases from min to max with no decrease
    % This time we use a sine function that starts at 0 and ends at +1
    glob.flowSedVolHistory(t) = glob.flowSedVolStart + ...
        (glob.flowSedVolOscillationAmplitude * sin((t / glob.maxIts) * (pi / 2)));
end


% function [glob] = initializeSedimentSupplyParamsIB(glob)
% 
% %     min to max to min
% 
%     % Set the starting sediment volume to the minimum volume 
%     glob.flowSedVolStart = glob.flowSedVolMin;
% 
%     % Calculate the oscillation amplitude (which is half the range between max and min)
%     glob.flowSedVolOscillationAmplitude = (glob.flowSedVolMax - glob.flowSedVolMin) / 2;
% 
% 
%     % Create a time vector
%     t = 1 : glob.maxIts;
% 
%     % Create the flowSedVolHistory that starts at min, increases to max, and falls back to min
%     % Use a sine function to complete a full cycle from 0 to 2π
%     glob.flowSedVolHistory(t) = glob.flowSedVolStart + ...
%         glob.flowSedVolOscillationAmplitude * (1 + sin((t / glob.maxIts) * pi));
%     glob.flowSedVolHistory(t) = glob.flowSedVolHistory(t) - ((glob.flowSedVolMax - glob.flowSedVolMin) / 2);
% 
% end

% function [glob] = initializeSedimentSupplyParamsIB(glob)
% 
%     %max to min to max
%     % Set the starting sediment volume to the maximum volume
%     glob.flowSedVolStart = glob.flowSedVolMax;
% 
%     % Calculate the oscillation amplitude (which is half the range between max and min)
%     glob.flowSedVolOscillationAmplitude = (glob.flowSedVolMax - glob.flowSedVolMin) / 2;
% 
%     % Create a time vector
%     t = 1 : glob.maxIts;
% 
%     % Create the flowSedVolHistory that starts at max, decreases to min, and rises back to max
%     % Use a sine function to create the inverted U shape
%     glob.flowSedVolHistory(t) = glob.flowSedVolStart - ...
%         glob.flowSedVolOscillationAmplitude * (1 + sin((t / glob.maxIts) * pi));
% 
% end









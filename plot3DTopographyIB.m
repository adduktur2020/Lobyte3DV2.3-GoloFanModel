function plot3DTopographyIB(depos, glob)
    % plot3DTopography Creates a 3D plot of deposition thickness over iterations
    %
    % Parameters:
    %   depos - Structure containing deposition data
    %   glob - Structure containing global parameters such as dimensions

    figure; % Create a new figure window
    hold on; % Hold on to add multiple plots in the same figure

    % Define a color map with alternating colors
    colors = lines(glob.totalIterations); % 'lines' is a built-in colormap, you can choose any other like 'jet', 'hsv'

    % Get x and y coordinates for plotting
    [X, Y] = meshgrid(1:glob.xSize, 1:glob.ySize);

    for t = 2:glob.totalIterations % Start from 2 assuming 1 is initial conditions
        % Get the matrix of deposition thicknesses for the current iteration
        thickness = depos.transThickness(:, :, t);
        elevation = depos.elevation(:, :, t);

        % Find grids where deposition thickness is greater than 0.1
        idx = thickness > 0.1;

        % Extract the deposition thickness and corresponding elevations
        plotThickness = thickness(idx);
        plotElevation = elevation(idx);
        plotX = X(idx);
        plotY = Y(idx);

        % Create a scatter plot in 3D, coloring based on iteration
        scatter3(plotX, plotY, plotElevation, 36, colors(t,:), 'filled');

        % Optionally, draw outlines around areas with deposition
        for k = 1:length(plotX)
            text(plotX(k), plotY(k), plotElevation(k), num2str(t), 'HorizontalAlignment', 'center', 'Color', 'k');
        end
    end

    % Setting the aesthetic features of the plot
    colormap(colors); % Apply the colormap
    colorbar; % Show the colorbar indicating the iteration numbers
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    zlabel('Elevation');
    title('3D Topographic Development Over Iterations');
    grid on; % Turn on the grid
    view(3); % Set the view to 3D perspective

    hold off; % Release the hold to allow new plots in future
end

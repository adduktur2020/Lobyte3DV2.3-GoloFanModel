function plot2DViewWithRoutesIB(glob, depos)
    % Create a new figure
    figure;
    
    % Plot the 2D view of lobes
    lobeMatrix = zeros(glob.ySize, glob.xSize);
    for y = 1:glob.ySize
       for x = 1:glob.xSize
           topChron = find(depos.transThickness(y, x, :) > 0, 1, 'last');
           if ~isempty(topChron)
               lobeMatrix(y, x) = depos.flowLobeNumber(topChron);
           end
       end
    end

    % Using imagesc to create a 2D plot of the lobe distribution
    imagesc(lobeMatrix);
    colormap(jet(max(lobeMatrix(:)))); % Apply a colormap
    colorbar; % Add a colorbar to indicate lobe numbers
    hold on; % Keep the lobe plot

    % Overlay the flow routes
    for j = 2:glob.totalIterations % Assume starting from 2 as 1 is initial condition
        xco = glob.transRouteXYZRecord(:, 1, j) .* glob.dx; % Get X coordinates
        yco = glob.transRouteXYZRecord(:, 2, j) .* glob.dy; % Get Y coordinates
        validIndices = xco > 0 & yco > 0; % Filter valid coordinates
        plot(xco(validIndices), yco(validIndices), 'w-', 'LineWidth', 1); % Plot routes in white for visibility
    end

    hold off; % Release the plot
    axis equal tight; % Adjust axis
    title('2D View of Lobes and Flow Routes');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
end

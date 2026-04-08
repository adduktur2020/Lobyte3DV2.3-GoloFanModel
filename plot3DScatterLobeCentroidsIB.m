function plot3DScatterLobeCentroidsIB(glob, depos, newFigure)
    if newFigure
        figure;
    end
    
    % Number of lobes
    numLobes = max(depos.flowLobeNumber);
    
    % Prepare colors - one for each lobe
    colors = jet(numLobes); % 'jet' colormap provides a range of colors
    
    % Hold on to plot all points in the same figure
    hold on;
    grid on; % Enable the grid for better visualization
    
    % Plot each lobe's centroid with a unique color
    for i = 1:numLobes
        % Find centroids belonging to the current lobe
        lobeIndices = find(depos.flowLobeNumber == i);
        
        % Extract the coordinates and elevation of centroids for the current lobe
        x = glob.centroidX(lobeIndices);
        y = glob.centroidY(lobeIndices);
        z = depos.elevation(lobeIndices); % Assuming this is how elevation is stored
        
        % Plot using scatter3
        scatter3(x, y, z, 36, colors(i, :), 'filled'); % Adjust the size (36) as needed
        
        % Labeling each lobe's centroid group (optional)
        text(mean(x), mean(y), mean(z) + max(z)*0.05, sprintf('Lobe %d', i), 'HorizontalAlignment', 'center');
    end
    
    % Set labels and title
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    zlabel('Elevation');
    title('3D Scatter Plot of Lobe Centroids');
    
    % Legend and colorbar might not be directly applicable due to the nature of scatter plots,
    % but you can add a custom legend or annotations if necessary.
    
    hold off; % Release the figure for other commands
end

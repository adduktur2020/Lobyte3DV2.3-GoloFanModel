function plot2DViewLobesIB2(glob, depos, newFigure)
    if newFigure
        figure;
    end

    % Assuming glob.ySize and glob.xSize define the grid size
    % Initialize a matrix to store the lobe number for the top (latest) deposit at each grid point
    lobeMatrix = zeros(glob.ySize, glob.xSize);
    
    % Loop over each grid point to find the lobe number of the top deposit
    for y = 1:glob.ySize
       for x = 1:glob.xSize
           topChron = find(depos.transThickness(y, x, :) > 0, 1, 'last');
           if ~isempty(topChron)
               lobeMatrix(y, x) = depos.flowLobeNumber(topChron);
           end
       end
    end

    % Create a colormap for the number of lobes
    cmap = jet(max(lobeMatrix(:)));
    
    % Plot each cell as a patch
    hold on;
    for y = 1:glob.ySize
       for x = 1:glob.xSize
           % Skip plotting for cells with no data
           if lobeMatrix(y, x) == 0
               continue;
           end
           
           % Determine color based on the lobe number
           color = cmap(lobeMatrix(y, x), :);
           
           % Create a patch for the cell
           patch([x-1, x, x, x-1], [y-1, y-1, y, y], color, 'EdgeColor', 'k', 'FaceAlpha', 0.5);
       end
    end
    hold off;

    % Adjust the axis for equal spacing and tight fit, and set other plot properties
    axis equal tight;
    title('2D View of Flow Deposits by Lobe with Transparency and Edge Colors');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    colormap(cmap); % Apply the colormap
    colorbar; % Show a colorbar for reference
end

function plot2DViewLobesIB(glob, depos, newFigure)
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

    % Plot the 2D view

    imagesc(lobeMatrix);
    colormap(jet(max(lobeMatrix(:)))); % Use the 'jet' colormap with a range based on the number of lobes
    colorbar; % Show a colorbar for reference
    axis equal tight; % Adjust the axis for equal spacing and tight fit
    title('2D View of Flow Deposits by Lobe');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    
end

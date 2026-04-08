function plot2DViewIB(glob, depos, newFigure, lobeOrFlowColourCoding, transparency)
    % Check if a new figure window should be opened
    if newFigure
        figure;
    end

    % Initialize matrices to store the top chron (youngest layer) and the cumulative thickness at each grid point
    topChron = zeros(glob.ySize, glob.xSize);
    deposThickness = zeros(glob.ySize, glob.xSize);
    
    % Loop across the xy grid to calculate the top chron and cumulative thickness
    for y = 1:glob.ySize-1
       for x = 1:glob.xSize-1 
            deposThickness(y,x) = sum(depos.transThickness(y,x,1:glob.totalIterations)); % Sum flow thicknesses at each grid point
            
            for j = 1:glob.totalIterations   
                if depos.transThickness(y,x,j) > 0
                    topChron(y,x) = j; % Record the youngest layer with non-zero thickness at point xy
                end
            end
       end
    end
    
    % Loop to draw the 2D representation of the flows
    for y = 1:glob.ySize-1
       for x = 1:glob.xSize-1 
           if deposThickness(y,x) > 0.01 % Check if the point should be drawn based on thickness
                xco = [x*glob.dx, (x+1)*glob.dx, (x+1)*glob.dx, x*glob.dx];
                yco = [y*glob.dy, y*glob.dy, (y+1)*glob.dy, (y+1)*glob.dy];
                
                % Determine the color based on lobe assignment if lobeOrFlowColourCoding is set accordingly
                if lobeOrFlowColourCoding == 1
                    lobeNumber = depos.flowLobeNumber(topChron(y,x));
                    thicknessColour = depos.flowColoursByLobe(lobeNumber,:);
                else % Default to individual flow colors if not using lobe color coding
                    thicknessColour = depos.flowColours(topChron(y,x),:);
                end
                
                % Draw the area with the specified color and transparency
                fill(xco, yco, thicknessColour, 'EdgeColor', 'none', 'FaceAlpha', transparency);
            end
        end 
    end
end

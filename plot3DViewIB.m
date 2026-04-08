function plot3DViewIB(glob, depos, newFigure, lobeOrFlowColourCoding, transparency)

    if newFigure
        figure
    end

    % Initialize matrices
    topChron = zeros(glob.ySize, glob.xSize);
    deposThickness = zeros(glob.ySize, glob.xSize);
    
    % Calculate depositional thickness and chronology
    for y = 1:glob.ySize-1
       for x = 1:glob.xSize-1
            deposThickness(y,x) = sum(depos.transThickness(y,x,1:glob.totalIterations));
            
            for j = 1:glob.totalIterations
                if depos.transThickness(y,x,j) > 0
                    topChron(y,x) = j;
                end
            end
       end
    end

    % Adjust the scale of topography data if necessary
    [X, Y] = meshgrid(1:glob.dx:glob.xSize*glob.dx, 1:glob.dy:glob.ySize*glob.dy);
    % Assuming the elevation data is on a smaller scale and needs to be interpolated
    Z = interp2(depos.elevation(:,:,1), linspace(1,size(depos.elevation,2), size(X,2)), linspace(1,size(depos.elevation,1), size(Y,1))', 'linear');
    
    % Plot Topography
    surf(X, Y, Z, 'EdgeColor', 'none'); % Plot as a smooth surface
    hold on; % Keep the topography plot for overlaying the deposition patches

    % Overlay Deposits on adjusted scale
    for y = 1:glob.ySize-1
       for x = 1:glob.xSize-1
           if deposThickness(y,x) > 0.1
                % Adjust coordinates to the new scale
                yco = [y, y, y+1, y+1] * glob.dy;  
                xco = [x, x+1, x+1, x] * glob.dx;
                zco = [depos.elevation(y,x,1) + deposThickness(y,x), depos.elevation(y,x+1,1) + deposThickness(y,x+1), ...
                    depos.elevation(y+1,x+1,1) + deposThickness(y+1, x+1), depos.elevation(y+1,x,1) + deposThickness(y+1,x)];
                
                % Determine color
                if lobeOrFlowColourCoding ~= 1
                    thicknessColour = [depos.flowColours(topChron(y,x),1), depos.flowColours(topChron(y,x),2), depos.flowColours(topChron(y,x),3)];
                else
                    thicknessColour = [depos.flowColoursByLobe(topChron(y,x),1), depos.flowColoursByLobe(topChron(y,x),2), depos.flowColoursByLobe(topChron(y,x),3)];
                end
                patch(xco,yco,zco, thicknessColour, 'EdgeColor', 'none', 'facealpha', transparency);
            end
        end 
    end
    
    hold off; % Release the plot
end

function glob = calculateCentroidsAndFlowOverlaps(glob, depos)
% Calculate the centroid of transported sediment deposition at each time step
% multiply this by the inverse of the normalized flow overlap area to give a final flow separation metric

    centroidX = zeros(1, glob.totalIterations);
    centroidY = zeros(1, glob.totalIterations);
    centroidSeparation = zeros(1, glob.totalIterations);
    
    for t = 1:glob.totalIterations
        pointCount = 0;
        totalX = 0;
        totalY = 0;
        for x = 2:glob.xSize-1
            for y = 1:glob.ySize-1
                if depos.transThickness(y,x,t) > glob.thicknessThreshold
                    % Add x & y coordinates of a point where there has been deposition,
                    % to form vectors of x and y coordinates for the time step t deposition
                    totalX = totalX + x; 
                    totalY = totalY + y;
                    pointCount = pointCount + 1;
                end
            end
        end
        
        % If there are no depositional points, use the average centroid from previous time steps
        if pointCount == 0 && t > 1
            centroidX(t) = mean(centroidX(1:t-1));
            centroidY(t) = mean(centroidY(1:t-1));
        elseif pointCount > 0
            centroidX(t) = totalX / pointCount;
            centroidY(t) = totalY / pointCount;
        end
    end
    
    % Now calculate the separation distance of the centroids, specifically centroid(t) from centroid(t-1)
    for t = 2:glob.totalIterations
        deltaX = centroidX(t) - centroidX(t-1);
        deltaY = centroidY(t) - centroidY(t-1);
        centroidSeparation(t) = sqrt((deltaX * deltaX) + (deltaY * deltaY));
    end
    
    flowOverlapRecord = calculateFlowOverlapRecord(glob, depos);   
    glob.flowOverlapRecord = flowOverlapRecord;
    glob.centroidSeparation = centroidSeparation;
    glob.centroidX = centroidX;
    glob.centroidY = centroidY;
end

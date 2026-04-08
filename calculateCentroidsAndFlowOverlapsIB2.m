function glob = calculateCentroidsAndFlowOverlapsIB2(glob, depos)
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
        
        % If there are no depositional points, use the average centroid from neighboring cells
        if pointCount == 0
            averageX = 0;
            averageY = 0;
            count = 0;
            for x = 2:glob.xSize-1
                for y = 1:glob.ySize-1
                    neighborX = 0;
                    neighborY = 0;
                    neighborCount = 0;
                    for i = -1:1
                        for j = -1:1
                            if (x+i >= 2 && x+i <= glob.xSize-1 && y+j >= 1 && y+j <= glob.ySize-1) && ...
                               (depos.transThickness(y+j,x+i,t) > glob.thicknessThreshold)
                                neighborX = neighborX + (x+i);
                                neighborY = neighborY + (y+j);
                                neighborCount = neighborCount + 1;
                            end
                        end
                    end
                    if neighborCount > 0
                        averageX = averageX + neighborX / neighborCount;
                        averageY = averageY + neighborY / neighborCount;
                        count = count + 1;
                    end
                end
            end
            if count > 0
                centroidX(t) = averageX / count;
                centroidY(t) = averageY / count;
            else
                centroidX(t) = eps; % Use a small epsilon value if no centroid found
                centroidY(t) = eps;
            end
        else
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

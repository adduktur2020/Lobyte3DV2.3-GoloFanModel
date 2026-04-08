function plot3DStrataVolumeIB(glob, depos)

    % Number of effective layers for visualization
    numEffectiveLayers = glob.totalIterations + 1;  % +1 for the initial topography layer

    % Initialize the volume matrix with zero thickness
    volumeData = zeros(glob.ySize, glob.xSize, numEffectiveLayers);

    % Interpolate elevation data to match the grid size
    [Xq, Yq] = meshgrid(1:glob.xSize, 1:glob.ySize);
    elevationInterpolated = interp2(depos.elevation(:,:,1), Xq, Yq, 'linear', 0);

    % First layer of volumeData is set to elevation
    volumeData(:,:,1) = elevationInterpolated;

    % Accumulate deposition layers above the base topography
    for y = 1:glob.ySize-1
        for x = 1:glob.xSize-1
            baseElevation = elevationInterpolated(y,x);
            for j = 1:glob.totalIterations
                volumeData(y,x,j+1) = baseElevation + sum(depos.transThickness(y,x,1:j));
            end
        end
    end
    
    % Generate a distinct color map using MATLAB's built-in 'lines' function
    distinctColors = lines(glob.totalIterations);

    % Include a base color (e.g., black for the topography) and use distinct colors for layers
    colormapData = [0 0 0; distinctColors]; % Black for topography, distinct colors for each layer

    % Create a figure and use volshow
    fig = figure;
    h = volshow(volumeData, 'Colormap', colormapData);

    % Set the background color on the parent Viewer3D of the volume
    h.Parent.BackgroundColor = [0 0 0];
end

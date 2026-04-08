function plotAdvancedPlots(glob, depos)

        % Define two cross-section positions, to calculate stats through the model
        xCross = 280; %225; %266; %220; %260 Position of the dip-oriented section on the x-axis 195 214opt
        yCross = 320; %265; %285; %260; % 280 Position of the strike-oriented section on the y-axis 190 204opt
        glob.sedimentSupplyFreq = 1.0 / glob.flowSedVolOscillationPeriod; % Define this here because not defined in glob in currently saved versions of the two model runs loaded in the lines above
        glob.thicknessThreshold = 0.1; % Thickness threshold used for various post-run analysis e.g. strat completeness, runs analysis
        glob.modelName = "GoloFan";
        
        % Set the flow colour for each iteration. Note that lobe colours are set in function calculateFanLobesFromFlowApices
        depos.flowColours = zeros(glob.totalIterations,3);
        depos.flowColours(1:glob.totalIterations,:) = [ones(glob.totalIterations,1), rand(glob.totalIterations,1), zeros(glob.totalIterations,1)];
        
        % plotFlowCentroidTimeseries(glob, depos);
%         plotFlowApecesTimeseries(glob, depos);
%         plotLobeVolumeTimeseries(glob, depos);
        plotLobeVolumeTimeseriesIB2(glob, depos);
        

%         % movie to show how deposition occur at each timestep
%          plot3DViewMovieIB(glob, depos, 1, 0.75,'3DMovie')
%          makeDepositionMovieIB(glob, depos) % 3D movie
%          makeDepositionMovie2D(glob, depos)
%          makeDepositionMovie(glob, depos)
%          plot2DViewLobesIB(glob, depos, 1)
%          plot2DViewLobesIB3(glob, depos, 1)
%          plot2DViewWithRoutesIB(glob, depos)
%          plot3DScatterLobeCentroidsIB(glob, depos, 1)
%           plot3DStrataVolumeIB(glob, depos)
%           plotDeposition3DIB(glob, depos)

% intervals = [1, 10, 20, 30, 40, 50];  % Capture snapshots at these iterations
% outputDir = 'modelOutput\OutputDir';
% generateTopographySnapshotsIB(depos, glob, intervals, outputDir);
% plot3DTopographyIB(depos, glob)
% plotFlowPathsIB(depos, glob)

        
%         calculate/compare area of model fan area with actual Golo fan area
        cellArea = 0.1; % 1 square meter per grid cell
        [area_error, fig] = plotDepositionBoundaryWithOverlayAndAreasIB(glob, depos, cellArea);

%         plotRealGoloFanWell % plot digitized actual Golo fan well data

%       plot vertical sections of modeled well data with statistics.
        [thickness_error, fig] = plotVerticalSectionWithStatsIB(glob, depos, xCross, yCross, glob.modelName);

%         Combining error
        w_area = 0.5; % half weight from fan area error
        w_thickness = 0.5; % half weight from vertical section error
        combined_error = w_area * area_error + w_thickness * thickness_error;
        fprintf('Error at this iteration: %.2f ', combined_error);
        fprintf('\n');
        writematrix(combined_error, 'totalError.txt');

        fprintf("Plot flow apices positions, xy iteration ...")
%         plotEvolution3DWithTimeIB(glob)
        % plot3DViewIB(glob, depos, 1, 0, 0.75)
        % plot3DView(glob, depos, 1, 1, 0.75)
        % plotFlowApecesXYZ(glob, 0)
        fprintf("Done\n")

        % plotIsopachMapIB2(glob, depos, glob.thicknessThreshold, glob.modelName)
        % plotIsopachMapAndTrackSedimentIB(glob, depos, glob.thicknessThreshold, glob.modelName)
%         plotIsopachMapAndTrackSedimentDBSCANIB(glob, depos, glob.thicknessThreshold, glob.modelName)


%         Define global parameters (glob) and deposition data (depos) as usual

        % %Generate three Isopach Maps
        % % Get total iterations
        % totalIterations = glob.maxIt;
        % 
        % % Divide iterations into three parts
        % firstQuarter = floor(totalIterations / 3);
        % secondQuarter = floor(2 * totalIterations / 3);
        % thirdQuarter = totalIterations;
        % 
        % % Set the threshold for thickness
        % % thicknessThreshold = 1; % Example threshold, adjust as needed
        % 
        % % Call the function three times, passing different iterations
        % 
        % % First quarter
        % glob.maxIt = firstQuarter;
        % modelNameFirst = sprintf('%s - First Quarter', glob.modelName);
        % plotIsopachMapAndTrackSedimentIB(glob, depos, glob.thicknessThreshold, modelNameFirst);
        % 
        % % Second quarter
        % glob.maxIt = secondQuarter;
        % modelNameSecond = sprintf('%s - Second Quarter', glob.modelName);
        % plotIsopachMapAndTrackSedimentIB(glob, depos, glob.thicknessThreshold, modelNameSecond);
        % 
        % % Third quarter
        % glob.maxIt = thirdQuarter;
        % modelNameThird = sprintf('%s - Third Quarter', glob.modelName);
        % plotIsopachMapAndTrackSedimentIB(glob, depos, glob.thicknessThreshold, modelNameThird);


        
%         plotSingleFlowMapsAnimated(glob, depos, 2, 200, 1); 
        
%         plotTraverseAnimation(glob, depos);

        % fprintf('Plot cross sections...');
        % plotCrossSectionStrikeDirection(glob, depos, yCross, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, xCross, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, 250, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, 240, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, 230, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, 220, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, 210, 0,0,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, 200, 0,0,0, 1, glob.modelName);
        % plotCrossSectionStrikeDirection(glob, depos, yCross, 210,235,0, 1, glob.modelName);
        % plotCrossSectionDipDirection(glob, depos, xCross, 210,280,0, 1, glob.modelName);
        % fprintf('Done\n');

%         fprintf('Plot vertical sections...');
%         plotVerticalSection(glob, depos, xCross, yCross, glob.modelName);
%         plotVerticalSection(glob, depos, 230, yCross, glob.modelName);
%         fprintf('Done\n');

%         fprintf('Plot vertical section and correlative chronostrat');
%         plotVerticalSectionAndChronostratsTriangles(glob, depos, xCross, yCross, glob.modelName);
%         fprintf('Done\n');

%         
%         fprintf("Plot 3D view of flow history ...")
%         plotSingleFlowMaps(glob, depos, 2, glob.it-1);
%         fprintf("Done\n")

          % fprintf('Plot flow centroids...');
          % plotCentroids(glob, depos, glob.modelName);
          % fprintf('Done\n');

%           
%           fprintf('Plot chronostrat diagrams slices through model animation...');
%           plotChronostratTraverseAnimation(glob, depos);
%           fprintf('Done\n');

%           fprintf('Plot maps, P value, strat completeness and maximum power spectra frequencies etc...');
%           plotStatsMaps(glob, depos, glob.modelName);
%           fprintf('Done\n');
          
%           fprintf('Plot significant spectral peaks count bar chart...');     
%           plotSpectralPeakCounts(glob.significantPeakCount, glob.sedimentSupplyPeriod, glob.modelName); % Note updated on 25.7 to send just sigPeakCount rather than all of glob structure, and then sediment supply period added too
%           fprintf('Done\n');
% 
%           fprintf('Plot bed thickness distribution etc...');
%           plotBedThicknessDistribution(glob, depos);
%           fprintf('Done\n');

%           fprintf('Calculate and plot power spectra at X=97, Y=50 ...');
%           [~] = oneSectionPowerSpectrumAnalysis(glob, depos.transThickness, xCross, yCross, 500, 1, 50, 500, 1);
%           [~] = oneSectionPowerSpectrumAnalysis(glob, depos.transThickness, xCross, 150, 500, 1, 50, 500, 1);
%           [~] = oneSectionPowerSpectrumAnalysis(glob, depos.transThickness, 190, 125, 500, 1, 50, 500, 1);
%           [~] = oneSectionPowerSpectrumAnalysis(glob, depos.transThickness, 190, 150, 500, 1, 50, 500, 1);
          
%    
% 
%         plotPvsCompleteness(glob, depos);
%         
%         fprintf('Analysing flow overlap time series...');
%         analyseFlowOverlapTimeseries(glob);
%         fprintf('Done\n');

  
end
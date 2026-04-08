% Step 1: Load data from the Excel file
filename = 'bigFanCentroid.xlsx'; 
data = xlsread(filename);

% Step 2: Extract x, y coordinates, and timing
x = data(:,2); 
y = data(:,3);
timing = data(:,1);

% Step 3: Create the scatter plot
figure;
scatter(x, y, 50, timing, 'filled'); 
colormap(jet);
c = colorbar;
c.Label.String = 'Flow Centroid Chronology';      % Optional: add label to colorbar
c.Label.FontSize = 20;
c.Label.FontWeight = 'bold';

% Step 4: Aesthetics & formatting
grid on;
axis equal;

% Step 5: Bold axis labels, title & adjust font sizes
xlabel('X-Distance (km)', 'FontSize', 20, 'FontWeight', 'bold');
ylabel('Y-Distance (km)', 'FontSize', 20, 'FontWeight', 'bold');

% Use TeX formatting for m^3
% title('Low - Sediment Volume: 100{,}000 m^3', ...
%       'FontSize', 22, 'FontWeight', 'bold', 'Interpreter', 'tex');
title('Low Freq. Cyclic Sediment Volume', ...
      'FontSize', 22, 'FontWeight', 'bold', 'Interpreter', 'tex');

% Step 6: Bold & resize tick labels
set(gca, 'FontSize', 18, 'FontWeight', 'bold');

% Step 7: Save high-quality figure (choose 300–600 dpi)
% print('BestFit_SedimentVolume', '-dpng', '-r600');   % 600 dpi PNG
% print('BestFit_SedimentVolume', '-dtiff', '-r600'); % or TIFF (preferred for journals)

% code to generate the spatial grids used for validation and classification
% 2025-01-10
% Rapolas Daugintis, Roberto Barumerli

clc

s_3d3a = "LAP/lap-task1-hrtfs/3d3a/Subject1_HRIRs.sofa";
s_chedar = "LAP/lap-task1-hrtfs/chedar/chedar_0001_UV2m.sofa";
s_hutubs = "LAP/lap-task1-hrtfs/hutubs/pp2_HRIRs_measured.sofa";
s_riec = "LAP/lap-task1-hrtfs/riec/RIEC_hrir_subject_001.sofa";
s_sadie2 = "LAP/lap-task1-hrtfs/sadie2/H10_96K_24bit_512tap_FIR_SOFA.sofa";
s_scut = "LAP/lap-task1-hrtfs/scut/SCUT_NF_subject0001_measured.sofa";
s_sonicom = "LAP/lap-task1-hrtfs/sonicom/P0001_FreeFieldComp_96kHz.sofa";
s_widespread = "LAP/lap-task1-hrtfs/widespread/UV2m_00001.sofa";

s_fns = {s_3d3a, s_chedar, s_hutubs, s_riec, s_sadie2, s_scut, s_sonicom, s_widespread};

pos = {};

for n=1:length(s_fns)
    disp(s_fns{n})
    s = SOFAload(s_fns{n});

    disp("Sampling rate: " + num2str(s.Data.SamplingRate))
    
    disp("Duration: " + size(s.Data.IR,3)/s.Data.SamplingRate*1000)
    
    disp("No. positions: " + size(s.Data.IR,1))
    
    disp("Radius: " + s.SourcePosition(1, 3))
    
    pos{n} = s.SourcePosition;
    % disp(s.GLOBAL_Comment)
end

%%


% Loop through the rest of the cell array
for k = 1:length(pos)
    if k == 1
        % Initialize with the first cell array element
        common_positions = round(wrapTo180(pos{1}(:,1:2)));
    else
        common_positions = intersect(common_positions, round(wrapTo180(pos{k}(:,1:2))), 'rows');
    end
    % if any(pos{k}(:,1) == 0 & pos{k}(:,2) == 0)
    %     disp(k)
    %     disp(find(pos{k}(:,1) == 0 & pos{k}(:,2) == 0))
    % end
end

% Display result
disp('Common positions:');
disp(common_positions);

%%

% Extract azimuth and elevation from the array
azimuth = common_positions(:, 1);   % First column
elevation = common_positions(:, 2); % Second column

% Convert degrees to radians
azimuth_rad = deg2rad(azimuth);
elevation_rad = deg2rad(elevation);

% Convert spherical coordinates to Cartesian coordinates
x = cos(elevation_rad) .* cos(azimuth_rad);
y = cos(elevation_rad) .* sin(azimuth_rad);
z = sin(elevation_rad);

% Create a 3D scatter plot
figure;
scatter3(x, y, z, 50, 'filled'); % '50' sets marker size
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; % Ensures equal scaling
title('Classifier grid')

%% validation grid
% load ClubFritz grid
cfritz_positions = round(readmatrix("target_coords.csv"), 0);
cfriz_coords = barumerli2023_coordinates([cfritz_positions, ones(size(cfritz_positions, 1), 1)], 'spherical'); 

% plot new figure
cfriz_coords.plot()
hold on
scatter3(x, y, z, 50); % '50' sets marker size

% find intersection with classifier grid
classifier_coords = barumerli2023_coordinates([common_positions, ones(size(common_positions, 1), 1)], 'spherical'); 
idx = classifier_coords.find_positions(cfriz_coords);

% removing duplicates
nearest_coords = classifier_coords.subset(unique(idx));

% looking at the plot, it makes sense to also the coordinate [-170, 30] to
% keep symmetry (it does not get selected in the find positions)
nearest_coords.concatenate(barumerli2023_coordinates([-170,30, 1], 'spherical'));
writematrix(nearest_coords.return_positions('spherical'), 'cfritz_evaluation_coords.csv', 'Delimiter', ',')
r = nearest_coords.return_positions('cartesian');
scatter3(r(:, 1), r(:, 2), r(:, 3), 100, 'k'); % 
legend({'club fritz', 'classifier', 'intersection'})


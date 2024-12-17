%% load clubfritz templates and compute metrics and threhsolds
%
% 2023-03-08, Roberto Barumerli

clearvars
close all

load("task1_original.mat")
%% find intersection
target_coords = hrtf_grids{1,1};
num_hrtf = length(hrtf_grids);

% intersect to find the subset of directions common to all sets 
for i=2:num_hrtf
    if i == 6; continue; end
    if isempty(templates{i,1}); continue; end 
    C = intersect(round(target_coords.return_positions('horizontal-polar'), 0),...
                    round(hrtf_grids{i,1}.return_positions('horizontal-polar'), 0), 'rows');
    
    target_coords = barumerli2023_coordinates(C, 'horizontal-polar');
end

% we have 72 directions
figure
target_coords.plot()
hold on
scatter3(1, 0, 0, [], 'red')
view(30, 30)

% prepare for simulations
num_trials = 1e3;
metrics = cell(num_hrtf, num_hrtf);
data_points = cell(num_hrtf, num_hrtf);
targs_sph = target_coords.return_positions('spherical');

% simulate
parfor i = 1:num_hrtf % target
    fprintf('\n%i: ', i)
    if i == 6; continue; end
    for j = 1:num_hrtf % template
        if j == 6; continue; end
        fprintf(' %i,', j)

        % targ_az = targs_sph(median_plane_idx | horizontal_plane_idx, 1);
        % targ_el = targs_sph(median_plane_idx | horizontal_plane_idx, 2);
        targ_az = targs_sph(:, 1);
        targ_el = targs_sph(:, 2);
        targets = barumerli2023_featureextraction(sofas{i,1}, 'dtf',  'fs', sofas{i,1}.Data.SamplingRate, 'target', 'targ_az', targ_az, 'targ_el', targ_el);
    
        [m] = barumerli2023('template', templates{j}, ...
                                'target', targets, ...
                                'num_exp', num_trials, ...
                                'sigma_itd', .569, ...
                                'sigma_ild', .75, ...
                                'sigma_spectral', 4.3, ...
                                'sigma_motor', [],...
                                'sigma_prior', 11.5);
        
        data_points{i,j} = m;
    end
end

for i = 1:num_hrtf % target
    fprintf('\n%i: ', i)
    if i == 6; continue; end
    for j = 1:num_hrtf % template
        if j == 6; continue; end
        fprintf(' %i,', j)

        m = data_points{i,j};
        metrics{i,j} = barumerli2023_metrics(m, 'middle_metrics');
        metrics{i,j}.gainP = localizationerror(m, 'gainP');
        metrics{i,j}.accPnoquerr = localizationerror(m, 'accPnoquerr');
    end
end

fprintf('\n')

% dataset 6 has too few datapoints for the template computation
% i.e. spherical harmonic interpolation for template fails
metrics(6, :) = [];
metrics(:, 6) = [];

% removing outlier
% 2024-12-17
% I dont recall why I did this and it is probably a leftover from old code.
% Including this dataset would increase the threshold only for:
% rmsP (8.57 deg) and gain (0.48 1/deg)
metrics(3, :) = [];
metrics(:, 3) = [];

% rows are templates
accL = cellfun(@(x) x.accL, metrics);
accP = cellfun(@(x) x.accP, metrics);
rmsP = cellfun(@(x) x.rmsP, metrics);
querr = cellfun(@(x) x.querr, metrics);
gain = cellfun(@(x) x.gainP, metrics);
rmsL = cellfun(@(x) x.rmsL, metrics);
accPnoquerr = cellfun(@(x) x.accPnoquerr, metrics);


%% LATERAL ACCURACY
[threshold, med, matrix] = compute_threshold(accL);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('LATERAL ACCURACY')
xlabel('HRTF dataset')
ylabel('accL [deg]')

fprintf('the 4th quantile of the accL difference from inter-laboratory measurements is %.2f deg\n', threshold)

%% POLAR ACCURACY
[threshold, med, matrix] = compute_threshold(accP);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('POLAR ACCURACY')
xlabel('HRTF dataset')
ylabel('accP [deg]')

fprintf('the 4th quantile of the accP difference from inter-laboratory measurements is %.2f deg\n', threshold)

%% POLAR ERROR
[threshold, med, matrix] = compute_threshold(rmsP);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('POLAR ERROR')
xlabel('HRTF dataset')
ylabel('rmsP [deg]')

fprintf('the 4th quantile of the rmsP difference from inter-laboratory measurements is %.2f deg\n', threshold)

%% GAIN
[threshold, med, matrix] = compute_threshold(gain);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('GAIN')
xlabel('HRTF dataset')
ylabel('gain [1/deg]')

fprintf('the 4th quantile of the gain difference from inter-laboratory measurements is %.2f deg\n', threshold)


%% QUADRANT ERROR
[threshold, med, matrix] = compute_threshold(querr);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('QUERR')
xlabel('HRTF dataset')
ylabel('querr [%]')

fprintf('the 4th quantile of the Querr difference from inter-laboratory measurements is %.2f deg\n', threshold)

%% LATERAL ERROR
[threshold, med, matrix] = compute_threshold(rmsL);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('LATERAL ERROR')
xlabel('HRTF dataset')
ylabel('rmsL [deg]')

fprintf('the 4th quantile of the rmsL difference from inter-laboratory measurements is %.2f deg\n', threshold)

%% ACC P NO QUERR 
[threshold, med, matrix] = compute_threshold(accPnoquerr);

figure; 
boxplot(matrix)
hold on
plot(xlim, [1 1]*threshold)
title('ELEVATION BIAS')
xlabel('HRTF dataset')
ylabel('accPnoquerr [deg]')

fprintf('the 4th quantile of the accPnoquerr difference from inter-laboratory measurements is %.2f deg\n', threshold)

save('task1_thresholds_original.mat')

% these values are the third quartile
% 03-2024 before bug
% the 3rd quantile of the accL difference from inter-laboratory measurements is 1.966 deg
% the 3rd quantile of the accP difference from inter-laboratory measurements is 33.744 deg
% the 3rd quantile of the rmsP difference from inter-laboratory measurements is 4.109 deg
% the 3rd quantile of the gain difference from inter-laboratory measurements is 0.135 deg
% the 3rd quantile of the Querr difference from inter-laboratory measurements is 9.688 %
% the 3rd quantile of the rmsL difference from inter-laboratory measurements is 2.196 deg

% 2024-05-28 after bug
% the 3rd quantile of the accL difference from inter-laboratory measurements is 1.693 deg
% the 3rd quantile of the accP difference from inter-laboratory measurements is 33.133 deg
% the 3rd quantile of the rmsP difference from inter-laboratory measurements is 3.124 deg
% the 3rd quantile of the gain difference from inter-laboratory measurements is 0.146 deg
% the 3rd quantile of the Querr difference from inter-laboratory measurements is 6.228 deg
% the 3rd quantile of the rmsL difference from inter-laboratory measurements is 2.349 deg
% the 3rd quantile of the accPnoquerr difference from inter-laboratory measurements is 3.725 deg


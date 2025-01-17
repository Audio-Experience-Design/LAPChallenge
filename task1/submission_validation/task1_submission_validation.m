%% 
% This script requires AMToolbox v1.5.0 - www.amtoolbox.org - 
% and uses an auditory model to compute perceptual metrics deviation 
% from harmonized HRTF.
%
% Model reference: https://doi.org/10.1051/aacus/2023006
%
% This script loads the baseline metrics for all HRTF, computes the metrics
% for the submission indicated in 'participant' and returns the number
% of HRTF datasets valid (i.e. difference between baseline and harmonized
% metrics are below the thresholds)
% 
% 2024-07-01, Roberto Barumerli

clearvars 
close all

% start the AMT
% amt_start

rng(1024)

folder_original = 'LAP/lap-task1-hrtfs';
folder_harmonized = 'LAP/task1';

participant = 'IOA3D';
folder_harmonized = fullfile(folder_harmonized, participant);

hrtf_list = load_hrtf_list('hrtf_list.csv');

% load metrics for original HRTF
metrics_original_file = 'results/metrics_original_clubfritz_dirs.mat';
if exist(metrics_original_file, 'file')
    load(metrics_original_file, 'metrics_original');
else
    task1_compute_metrics_original
end

metrics_harmonized = cell(size(hrtf_list, 1),1);

% declare thresholds 
metrics_names = {'accL', 'rmsL', 'accP', 'rmsP', 'querr', 'gainP'};
thresholds = [5.86, 20.71, 12.67, 5.90, 34.56, 0.33]';

% iterate over HRTFs
for i = 30:size(hrtf_list,1)
    fprintf('Doing: %s - %s\n', hrtf_list{i,1}, hrtf_list{i,2})

    hrtf_original = fullfile(folder_original, hrtf_list{i,:});
    hrtf_harmonized = fullfile(folder_harmonized, hrtf_list{i,:});

    % compute metrics for harmonized
    metrics_harmonized{i,1} = compute_metrics(hrtf_original,hrtf_harmonized);
end


% test differences
differences = cell(size(hrtf_list, 1),2);

for i = 1:size(hrtf_list, 1)
    % compute and store difference 
    differences{i,1} = abs(structfun(@(x) x, metrics_harmonized{i,1}) - ...
                        structfun(@(x) x, metrics_original{i,1}));
    
    % test differences
    differences{i,2} = differences{i,1} < thresholds;
end

% compute how many HRTFs pass the evaluation
count = sum(cellfun(@(x) sum(x) == length(thresholds), differences(:,2)));

% print evaluation
if count > 64
    fprintf('The submission passed the validation with %i out of 80 sofa files\n', count)
else 
    fprintf('The submission did not pass the validation with %i out of 80 sofa files\n', count)
end

save(sprintf('results/evaluation_%s_common.mat', participant))

% 2024-07-01 - challenge evaluation
% using clubfritz grid
% IOA3D: 76 out of 80
% Bahu: 72 out of 80
% Kalimoxto: 69 out of 80


% 2025-01-10 - manuscript preparation
% using alternative grids
% IOA3D
%    classifier - 0 out of 80
%    common     - 1 out of 80
% Bahu
%    classifier - 71 out of 80
%    common     - 64 out of 80
% Kalimoxto
%    classifier - 19 out of 80
%    common     - 48 out of 80
%% 
% This script requires AMToolbox v1.5.0 - www.amtoolbox.org - 
% and uses an auditory model to compute perceptual metrics deviation 
% from harmonized HRTF.
%
% Model reference: https://doi.org/10.1051/aacus/2023006
%
% This script computes the baseline metrics for each HRTF dataset and saves
% the result in metrics_original.mat
% 
% 2024-07-01, Roberto Barumerli

clearvars 
close all

% start the AMT
amt_start

% setting seed for reproducibility
rng(1024)

folder_original = '...';

hrtf_list = load_hrtf_list('hrtf_list.csv');

metrics_original = cell(length(hrtf_list),1);

% iterate over HRTFs
parfor i = 1:size(hrtf_list,1)
    fprintf('Doing: %s - %s\n', hrtf_list{i,1}, hrtf_list{i,2})
    hrtf_path = fullfile(folder_original, hrtf_list{i,:});
    
    % compute metrics for original HRTF
    metrics_original{i,1} = compute_metrics(hrtf_path,hrtf_path);
end

% save results
save('results/metrics_original.mat', 'metrics_original', 'hrtf_list')

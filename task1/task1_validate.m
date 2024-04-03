%% 
% This script requires AMToolbox v1.5.0 - www.amtoolbox.org - 
% and uses an auditory model to compute perceptual metrics deviation 
% from harmonized HRTF
%
% Model reference: https://doi.org/10.1051/aacus/2023006
% 
% 2023-03-28, Roberto Barumerli

clearvars 
close all

% start the AMT
amt_start

% load directions resulting from the intersection 
% of grids in the Club Fritz colletion
target_coords = readtable("target_coords.csv");

hrtf_original = 'original_hrtf.sofa';
hrtf_harmonized = 'harmonised_hrtf.sofa';

sofa_original = SOFAload(hrtf_original);
sofa_harmonized = SOFAload(hrtf_harmonized);

% extract features for template and target
template = barumerli2023_featureextraction(sofa_original, 'dtf');
target = barumerli2023_featureextraction(sofa_original, ...
                                            'dtf', 'target', ...
                                            'targ_az', target_coords.az, ...
                                            'targ_el', target_coords.el);

%% compute metrics for original HRTF
[m] = barumerli2023('template', template, ...
                        'target', target, ...
                        'sigma_itd', .569, ...
                        'sigma_ild', .75, ...
                        'sigma_spectral', 4.3, ...
                        'sigma_motor', [],...
                        'sigma_prior', 11.5);
% computing metrics
metrics_original = barumerli2023_metrics(m, 'middle_metrics');
% adding gain
metrics_original.gainP = localizationerror(m, 'gainP');

%% compute metrics for harmonized HRTF
target_harmonized = ...
        barumerli2023_featureextraction(sofa_harmonized, ...
                                            'dtf', 'target', ...
                                            'targ_az', target_coords.az, ...
                                            'targ_el', target_coords.el);

[m] = barumerli2023('template', template, ...
                        'target', target_harmonized, ...
                        'sigma_itd', .569, ...
                        'sigma_ild', .75, ...
                        'sigma_spectral', 4.3, ...
                        'sigma_motor', [],...
                        'sigma_prior', 11.5);
metrics_harmonized = barumerli2023_metrics(m, 'middle_metrics');
metrics_harmonized.gainP = localizationerror(m, 'gainP');

% compute difference 
metrics_diff = structfun(@(x) x, metrics_harmonized) - ...
                        structfun(@(x) x, metrics_original);

% see task details to know more about these values
% the array is ordered as follows: accL, rmsL, accP, rmsP, querr, gainP
thresholds = [1.96, 2.20, 33.74, 4.11, 9.70, 0.14]';

% print results
if sum(metrics_diff < thresholds) == length(thresholds)
    fprintf('The harmonised HRTF is valid.\n')
else
    fprintf('%i out of 6 metrics are invalid.\n', ...
                                sum(metrics_diff > thresholds))
end

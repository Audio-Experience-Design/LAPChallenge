% this script is largely based on task1_validate.m but wrapper into a
% function for easier management
%
% 2024-07-01, Roberto Barumerli


function metrics = compute_metrics(hrtf_original, hrtf_harmonized)
    % load directions resulting from the intersection 
    % of grids in the Club Fritz colletion
    target_coords = readtable("target_coords.csv");
    
    sofa_original = SOFAload(hrtf_original);
    sofa_harmonized = SOFAload(hrtf_harmonized);
    
    % select HRIRs with farthest distance (e.g. SCUT collection)
    sofa_original = extract_only_farthest_distance(sofa_original); 
    sofa_harmonized = extract_only_farthest_distance(sofa_harmonized);
    
    % extract features for template and target
    template_file = fullfile(strcat(hrtf_original, '_template.mat'));
    
    if exist(template_file, 'file')
        load(template_file, 'template');
    else
        template = barumerli2023_featureextraction(sofa_original, 'dtf', 'fs', sofa_original.Data.SamplingRate);
        save(template_file, 'template');
    end

    target = ...
            barumerli2023_featureextraction(sofa_harmonized, 'fs', sofa_harmonized.Data.SamplingRate, ...
                                                'dtf', 'target', ...
                                                'targ_az', target_coords.az, ...
                                                'targ_el', target_coords.el);
    
    [m] = barumerli2023('template', template, ...
                            'target', target, ...
                            'sigma_itd', .569, ...
                            'sigma_ild', .75, ...
                            'sigma_spectral', 4.3, ...
                            'sigma_motor', [],...
                            'sigma_prior', 11.5, ...
                            'num_exp', 300);
    
    metrics = barumerli2023_metrics(m, 'middle_metrics');
    metrics.gainP = localizationerror(m, 'gainP');
    metrics.accP = localizationerror(m, 'accPnoquerr');
end

% This function checks if the provided SOFA file includes 
% measurements taken at different distances and selects only the farthest ones.
function sofa_output = extract_only_farthest_distance(sofa_input)
    sofa_output = sofa_input;

    % test presence multiple distances
    if length(unique(round(sofa_output.SourcePosition(:, 3), 2))) > 1
        % select maximum distance
        far_dist = max(sofa_output.SourcePosition(:, 3));
    
        % remove HRIRs by updating sofa object
        idx_remove = sofa_output.SourcePosition(:, 3) ~= far_dist;
        sofa_output.SourcePosition(idx_remove, :) = [];
        sofa_output.Data.IR(idx_remove, :, :) = []; 
        sofa_output.API.M = size(sofa_output.SourcePosition, 1);
    end
end

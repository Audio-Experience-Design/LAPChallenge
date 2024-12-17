%% load clubfritz and compute templates for models
%
% 2023-03-08, Roberto Barumerli

clearvars 
close all

hrtf_path = 'C:\repos\datasets\hrtfs\clubfritz';

num_exp = 1;
num_hrtf = 10;

hrtf_grids = cell(num_hrtf,1);
templates = cell(num_hrtf,1);
names = cell(num_hrtf,1);
sofas = cell(num_hrtf,1);

% parpool(4)
parfor i=1:num_hrtf
    sofa = SOFAload(fullfile(hrtf_path,sprintf('ClubFritz%i.sofa', i)));
    sofas{i, 1} = sofa;

    c = barumerli2023_coordinates(sofa);
    c.normalize_distance(); % we dont care about distance

    hrtf_grids{i,1} = c;

    % store name
    names{i,1} = sofa.GLOBAL_Organization;

    % normalize
    front_idx = c.find_positions(barumerli2023_coordinates([0,0,1], 'spherical'));
    hrir_front = sofa.Data.IR(front_idx, :, :);
    sofa.Data.IR = sofa.Data.IR ./ (max(abs(hrir_front(:)))+eps);

    if size(sofa.Data.IR, 1) > 225 % exclude one
        % extract features without using the SH interpolation 
        templates{i} = barumerli2023_featureextraction(sofa, 'dtf', 'fs', sofa.Data.SamplingRate);
    end
end

save('task1_original.mat', 'templates', 'names', 'hrtf_grids', 'sofas', 'num_hrtf')
% 
% % run analysis
% task1_process
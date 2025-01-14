function [threshold, med, matrix] = compute_threshold(metric)
    % remove reference
    matrix = abs(metric' - diag(metric'));
    % remove diagonal - (remove columns)
    % https://stackoverflow.com/questions/11709880/how-to-delete-the-diagonal-elements-of-a-matrix-in-matlab
    n = length(matrix);
    matrix=matrix';
    matrix(1:n+1:n*n)=[];
    matrix=reshape(matrix,n-1,n)';

    % threshold = quantile(matrix(:),1);
    threshold = max(matrix(:));

    med = median(matrix(:));
end
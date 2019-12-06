function [segmentation,centers,converge_L] = kmeans_segm(image,K,L,seed)

    % Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B). 
    [n_rows, n_cols, n_channel] = size(image);
    Ivec = reshape(double(image), n_rows * n_cols, n_channel);

    % Randomly initialize the K cluster centers
    rng(seed);
    centers_ind = randi([0, n_rows * n_cols], 1, K);
    centers = Ivec(centers_ind, :);
    % Compute all distances between pixels and cluster centers
    pre_dist = pdist2(centers, Ivec, 'euclidean');
    
    % Iterate L times
    for i = 1:L

        % Assign each pixel to the cluster center for which the distance is minimum
        [~, nearest_c] = min(pre_dist);
       
        % Recompute each cluster center by taking the mean of all pixels assigned to it
        for j = 1:K
            assigned_pixels = nearest_c == j;
            centers(j,:) = mean(Ivec(assigned_pixels,:));
        end
        % Recompute all distances between pixels and cluster centers
        new_dist = pdist2(centers, Ivec, 'euclidean');
        diff = max(abs(new_dist - pre_dist));
        if diff < 1e-2
            break;
        end
        pre_dist = new_dist;
    end
    converge_L = i;
    disp("converge at loop " + converge_L);
    [~, nearest_c] = min(pre_dist);
    segmentation = reshape(nearest_c, n_rows, n_cols, 1);
    
end


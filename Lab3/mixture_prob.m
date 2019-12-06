function prob = mixture_prob(image, K, L, mask)
nrows = size(image, 1);
ncols = size(image, 2);
Ivec = im2double(reshape(image, nrows * ncols, 3));
Mvec = reshape(mask, nrows * ncols, 1);
Ima = Ivec(find(Mvec == 1), :);
g = zeros(size(Ima, 1), K);
g1 = zeros(nrows * ncols, K);

% Randomly initialize the K components using masked pixels
[segmentation, centers] = kmeans(Ima, K);
cov = cell(K, 1);
cov(:) = {rand * eye(3)};

w = zeros(1, K);
for i = 1 : K
    w(i) = sum(segmentation == i) / size(segmentation, 1);
end

% Iterate L times
for i = 1 : L
%   Expectation: Compute probabilities P_ik using masked pixels
    for k = 1 : K
        mean_k = centers(k, :);
        cov_k = cov{k};
        diff = Ima - mean_k;
        g(:, k) = 1 / sqrt(det(cov_k) * (2 * pi)^3) * exp(-0.5 *...
            sum((diff * inv(cov_k) .* diff), 2));
    end
    p = g .* w;
    p = p ./ sum(p, 2);
    
%   Maximization: Update weights, means and covariances using masked pixels
    w = sum(p, 1) / size(p, 1);
    for k = 1 : K
        centers(k, :) = p(:, k)' * Ima / sum(p(:, k), 1);
        diff = Ima - centers(k, :);
        cov{k} = (diff' * (diff .* p(:, k))) / sum(p(:, k), 1);
    end
end

% Compute probabilities p(c_i) in Eq.(3) for all pixels I
for k = 1 : K
    diff = Ivec - centers(k, :);
    g1(:, k) = 1 / sqrt(det(cov{k}) * (2 * pi)^3) * exp(-0.5 *...
            sum((diff * inv(cov{k}) .* diff), 2));
end
prob = sum(g1 .* w, 2);
prob = reshape(prob, nrows, ncols, 1);
end


function [centers, radii] = fit_circles(frames, ballR, tol, sens)

centers = zeros(size(frames, 3), 4);
radii = zeros(size(frames, 3), 2);

rRange = [round(ballR-tol), round(ballR+tol)];

for i = 1:size(frames,3)
    [c, r] = imfindcircles(frames(:,:,i), rRange, 'Sensitivity', sens);
    if numel(r) == 1
        centers(i,:) = [c(1,:), NaN, NaN];
        radii(i,:) = [r(1,1), NaN];
    elseif numel(r) == 0
        centers(i,:) = [NaN, NaN, NaN, NaN];
        radii(i,:) = [NaN, NaN];
    elseif numel(r) == 2
        centers(i,:) = [c(1,:), c(2,:)];
        radii(i,:) = [r(1,1), r(2,1)];
    end
end

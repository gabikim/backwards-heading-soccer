function [vx, vy] = ball_vel(c, r_avg, fps)

% find and remove NaNs
fit_indices = find(~isnan(c(:,1)));
c = c(fit_indices,:);

% velocities are the slopes of the linear fits (first value in p arrays)
p_vx = polyfit(fit_indices, c(:,1), 1);
p_vy = polyfit(fit_indices, c(:,2), 1);

% calibration factor
cal = 0.02135/r_avg * fps; % m/px * fps

vx = p_vx(1) * cal; 
vy = -p_vy(1) * cal;
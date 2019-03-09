clc
clear
close all

shot = './FwdHeadVid/12.MOV';
fps = 240;
videoTrack = true;

%% process video frames
disp('Processing frames...')
v = VideoReader(shot);
frames = zeros(v.Height, v.Width, round(v.FrameRate*v.Duration), 'uint8');
count = 1;
while hasFrame(v)
    frames(:, :, count) = rgb2gray(readFrame(v));
    count = count + 1;
end

%% Show line to get size of ball and marker
% imshow(frames(:, :, 10))
% %%
% [~] = imdistline;

%% Get marker circles
R_mark = (30)/2; % ball radius estimate in px
tol_mark = 10; % tolerance on ball radius
sens_mark = 0.5; % sensitivity to find ball circle

disp('Getting position markers...')
[c_mark, r_mark] = fit_circles(frames(:,:,:), R_mark, tol_mark, sens_mark); %c is x y coordinates

%% Get ball circle
R_ball = 149/2;
tol_ball = 10;
sens_ball = 0.95;
disp('Getting ball marker...')
[c_ball, r_ball] = fit_circles(frames(:,:,:), R_ball, tol_ball, sens_ball); %c is x y coordinates


%% 

figure

for i = 1:size(frames,3)
    imshow(frames(:,:,i))
    
    r_curr = r_mark(i,1);
    x = c_mark(i,1);
    y = c_mark(i,2);
    th = 0:pi/50:2*pi;
    xunit = r_curr * cos(th) + x;
    yunit = r_curr * sin(th) + y;
    hold on
    h_1 = plot(xunit, yunit,'r', 'LineWidth',1.5);
    
    r_curr = r_mark(i,2);
    x = c_mark(i,3);
    y = c_mark(i,4);
    xunit = r_curr * cos(th) + x;
    yunit = r_curr * sin(th) + y;
    hold on
    h_2 = plot(xunit, yunit,'r', 'LineWidth',1.5);
    
    r_curr = r_ball(i,1);
    x = c_ball(i,1);
    y = c_ball(i,2);
    xunit = r_curr * cos(th) + x;
    yunit = r_curr * sin(th) + y;
    hold on
    h_3 = plot(xunit, yunit,'b', 'LineWidth',1.5);
    
    pause(0.5)
end
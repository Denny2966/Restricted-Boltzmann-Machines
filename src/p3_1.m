%% problem 3: model training
clear all
close all
T = 50;
K = 400;
B = 100;
C = 100;
alpha = 0.1;
lambda = 0.0001;

data_path = '../Data/';
train_data_x_name = 'MNISTXtrain.txt';
train_data_x = load([data_path, train_data_x_name]);

[ WP, WB, WC, xd, hk ] = mini_batch( train_data_x, T, B, C, K, alpha, lambda );

save r3_1 WP WB WC xd hk

%% 3(a)
clear all
close all
load r3_1
Y = xd;
GridImg = make_grid_image(Y,28,28,10,10,0.5);
imagesc(GridImg);
axis square;
axis off;

%% 3(b)
clear all
close all
load r3_1
disp(size(WP))
Y = WP';

for i = 1:4
    figure(i)
    GridImg = make_grid_image(Y(1+(i-1)*100:i*100,:),28,28,10,10,0.5);
    imagesc(GridImg);
    axis square;
    axis off;
end

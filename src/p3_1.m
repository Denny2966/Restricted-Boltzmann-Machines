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

[ WP, WB, WC ] = mini_batch( train_data_x, T, B, C, K, alpha, lambda );

save r3_1 WP WB WC
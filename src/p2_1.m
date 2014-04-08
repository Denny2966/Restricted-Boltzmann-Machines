clear all
close all
model_dire = '../Models/';
WP_file = [model_dire, 'MNISTWP.txt'];
WB_file = [model_dire, 'MNISTWB.txt'];
WC_file = [model_dire, 'MNISTWC.txt'];

WP=load(WP_file);
WB=load(WB_file);
WC=load(WC_file);

S = 500;
[xd, hk] = Gibbs_sampler(WP, WB, WC, S);

index = 1:500;
disp(size(xd))
Y = xd(mod(index,5)==0, :);


disp(size(Y))
GridImg = make_grid_image(Y,28,28,10,10,0.5);
imagesc(GridImg);
axis square;
axis off;

%%
clear all
close all
model_dire = '../Models/';
WP_file = [model_dire, 'MNISTWP.txt'];
WB_file = [model_dire, 'MNISTWB.txt'];
WC_file = [model_dire, 'MNISTWC.txt'];

WP=load(WP_file);
WB=load(WB_file);
WC=load(WC_file);

S = 500;
C = 100;

Y = [];

energy_trace = cell(1, 5);

for i=1:C
    [xd, hk] = Gibbs_sampler(WP, WB, WC, S);
    Y = [Y; xd(S, :)];
    if i <= 5
        first_term = zeros(1,S);
        for k = 1:S
            first_term(k) = -(xd(k, :)*(WP*hk(k, :)'))';
        end
        energy_trace{i} = first_term - WB*hk'- WC*xd';
    end
end

disp(size(Y))
GridImg = make_grid_image(Y,28,28,10,10,0.5);
imagesc(GridImg);
axis square;
axis off;

% X = 1:S;
% mark_cell = cell(1, 5);
% mark_cell{1} = 'g';
% mark_cell{2} = 'b--o';
% mark_cell{3} = 'r-.s';
% mark_cell{4} = 'p--p';
% mark_cell{5} = 'p+-';
% 
% 
% for i=1:3
%     plot(X, energy_trace{i}, mark_cell{i})
%     hold on
% end
% hold off
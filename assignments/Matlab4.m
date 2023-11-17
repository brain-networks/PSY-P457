clear all
close all
clc

addpath(genpath('../bct'));

%% Instructions
% In this assignment there are six exercises.
% 
% The first three contain uncommented code. Your job is to explain what the
% code is doing. That is, for each line, explain what it is doing (in your 
% own words). Then, at the end of the exercise, describe what the code, 
% collectively, is doing.
%
% In the next three exercises, the purpose of the code is described.
% However, there are errors. Your job is to fix the errors by rewriting the
% code.

% The code loads in the Drosophila melanogaster (fruit fly) connectome.
% 
%   Winding, M., Pedigo, B. D., Barnes, C. L., Patsolic, H. G., Park, Y., 
%   Kazimiers, T., ... & Zlatic, M. (2023). The connectome of an insect 
%   brain. Science, 379(6636), eadd9330.
%
% This dataset is on our github page. Download it move it to the "data"
% folder. It is named "drosophila_connetome.mat".
%
% Then download this script (if you haven't already) and move it to your
% "m" folder.

%% Exercise 1

load('../data/drosophila_connectome.mat');

[~,~,deg_total] = degrees_dir(A);
deg_total_sort = sort(deg_total,'descend');

num_to_plot = 100;

f = figure('units','inches','position',[2,2,6,6]);
scatter3(...
    coor(:,1),coor(:,2),coor(:,3),...
    deg_total/5,...
    deg_total >= deg_total_sort(num_to_plot),...
    'filled');
axis image
colormap([0.5,0.5,0.5; 1.0 0.0 0.0]);

%% Exercise 2

load('../data/drosophila_connectome.mat');

ci = community_louvain(A);

h = zeros(max(ci),max(celltypeidx));
for i = 1:max(ci)
    idx = ci == i;
    h(i,:) = hist(celltypeidx(idx),1:max(celltypeidx));
end

idx_sensory = contains(celltypename,'sensory');
[~,idxmax] = max(h(:,idx_sensory));

f = figure('units','inches','position',[2,2,6,6]);
scatter3(...
    coor(ci ~= idxmax,1),coor(ci ~= idxmax,2),coor(ci ~= idxmax,3),...
    deg_total(ci ~= idxmax)/15,...
    ones(1,3)*0.65);
hold on;
scatter3(...
    coor(ci == idxmax,1),coor(ci == idxmax,2),coor(ci == idxmax,3),...
    deg_total(ci == idxmax)/5,...
    'r',...
    'filled');
axis image
colormap([
    0.5 0.5 0.5;
    1.0 0.0 0.0]);

%% Exercise 3

load('../data/drosophila_connectome.mat');

[~,~,deg_total] = degrees_dir(A);
h = hist(deg_total,1:max(deg_total));

f = figure('units','inches','position',[2,2,6,6]);
bar(1:max(deg_total),h);
xlabel('degree');
ylabel('count');

%% Exercise 4
% In this exercise we want to find the nodes that sit at the boundaries of
% modules by calculate participation coefficient. Once we've calculated
% this measure, we want to plot the network using the force-directed layout
% and set nodes' colors proportional to their participation coefficient.

% load data
load('../data/drosophila_connectome.mat');

% detect communities
ci = community_louvain(A,[],[],'negative_asym');

% calculate participation coefficient
pc = participation_coef_sign(A,ci);

% threshold network
thr = 0.025;
Athr = threshold_proportional(A,thr);

% make graph
g = digraph(Athr);

% plot graph
f = figure;
ph = plot(g,...
    'Edgecolor',ones(1,3)*0.5,...
    'EdgeAlpha',0.01,...
    'nodecdata',ci,...
    'markersize',(sum(A,2) + sum(A,1)')/250);

%% Exercise 5
% In this exercise we want to find out the cell types of the nodes with the
% 100 largest strengths. We then want make a histogram of their cell types 
% to figure out which cell type is biggest.

% load data
load('../data/drosophila_connectome.mat');

% calculate degree
[deg_in,deg_out,deg_total] = strengths_dir(A);

% find k largest
k = 100;
[deg_top,idx_top] = mink(deg_total,k);

% get their cell types
c = celltypeidx(idx_top);

% make histogram
f = figure;
h = hist(c,1:max(celltypeidx));
bar(h);
xlabel('celltype');
ylabel('count');
set(gca,'xtick',1:max(celltypeidx),'xticklabel',celltypename);

%% Exercise 6
% In this exercise, we want to calculate network efficiency and compare its
% value against that of random networks.

% calculate distance matrix
d = distance_bin(+(A > 0));

% calculate efficiency
[lambda,eff] = charpath(d);

% generate some random networks (this might take a bit, so we'll leave the
% number of randomizations small).
nrand = 10;
nswap = 32;

% initialize array
effr = zeros(nrand,1);
for irand = 1:nrand
    
    % randomize network
    Ar = randmio_und(A,nswap);
    
    % get distance matrix
    dr = distance_bin(+(Ar > 0));
    
    % calculate efficiency
    [lambdar,effr(irand)] = charpath(d);
    
end

% calculate p-value
p = mean(effr >= eff);

% if p < 
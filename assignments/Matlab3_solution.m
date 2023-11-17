clear all
close all
clc

%% Instructions
% In this assignment, you'll analyze *two* brain networks: one represents
% functional connectivity and the other represents structural connectivity.

%% Exercise 1
% Where is *this* file saved? Move it to the "assignments" folder in your
% "PSY-P457-main" folder.

% Click "Run" (the green arrow) and make sure you select the option "Change
% Folder" if prompted. The command below prints the folder where the file
% is *actually* located. If it doesn't end with "assignments" then you need
% to move this file to the correct location. Please do so before
% proceeding.

disp(pwd);

%% Exercise 2
% Modify the example code from the github page so that you load in the file
% "brain_network_data.mat".
%
% What variables are in the workspace? From their dimensions and names, can
% you identify the structural and functional connectivity matrices? What
% are their names?

load brain_network_data.mat

%% Exercise 3
% Plot both the SC and FC matrices using the "imagesc" command. Rather than
% plotting the two matrices in separate figures, we'll use the "subplot"
% command to plot them side-by-side. To do this, you eed to specify the 
% number of subplots and their locations. For instance, if you wanted three
% subplots in a single row (1 row, 3 columns) and to plot a connectivity 
% matrix, CIJ, in the middle (2nd) subplot, you would write something like:
%
% >> subplot(1,3,2); imagesc(CIJ);
%
% For the structural and functional connectivity matrices, we only need two
% subplots. Structural connectivity should be in the first plot and
% functional connectivity should be in the second.

f = figure;
subplot(1,2,1); imagesc(fc)
subplot(1,2,2); imagesc(sc);

% What do you notice about the SC and FC matrices? HINT: replace the
% imagesc() command in the above plot with spy(). The course github page
% explains what the spy() command does. You can also type 'help spy' in the
% command line to learn more about that function.

f = figure;
subplot(1,2,1); spy(fc)
subplot(1,2,2); spy(sc);

%% Exercise 4
% Threshold your structural and functional connectivity matrices
% so they contain only the top 1% connections. Name the thresholded
% matrices "sc_thr" and "fc_thr".
% 
% Let's visualize these networks in anatomical space. We'll use the
% function adjacency_plot_und() to do this. To learn more about this
% function, type the following in the command window:
% 
% >> help adjacency_plot_und
%
% Follow the example code to plot the thresholded structural and functional
% networks. Before plotting each, be sure to create a new figure.
% 
% NOTE: the coordinates of each node are stored in the variable
% 'node_coor'.
%
% NOTE: To make the plots look a little nicer, on the line after you call 
% the plot3() function, write 'axis image'.
% 
% NOTE: to rotate each image, click + hold and move the cursor within the
% figure.

thr = 0.01;
sc_thr = threshold_proportional(sc,thr);

[ex,ey,ez] = adjacency_plot_und(sc_thr,node_coor);
f = figure;
plot3(ex,ey,ez);
axis image;

fc_thr = threshold_proportional(fc,thr);
[ex,ey,ez] = adjacency_plot_und(fc_thr,node_coor);
f = figure;
plot3(ex,ey,ez);
axis image;

%% Exercise 5
% You can use the "scatter3" command to make three-dimensional scatter
% plots. The first three arguments are the {x,y,z} coordinates, the next
% argument encodes the size of nodes, and the third their color. For
% instance, if we wanted to make a plot where node size is proportional to
% degree and color is proportional to strength (the total weight of a
% node's connections), we would write:
%
% >> degrees = degrees_und(sc);
% >> strengths = strengths_und(sc);
% >> f = figure;
% >> scatter3(node_coor(:,1),node_coor(:,2),node_coor(:,3),degrees,strengths,'o','filled');
% >> axis image;
%
% Adapt the code from the course github page to detect consensus
% communities for the structural connectivity matrix. Using the above lines
% of code as a template, plot nodes in three-dimensional anatomical space
% with color equal to consensus community assignment and node size
% proportional to degree.
%
% NOTE: Because this matrix is larger than the ones we've encountered in
% the past, it will take longer to run the community detection algorithm.
% Just be aware.

% number of times to repeat community detection algorithm
num_iter = 100;

% number of nodes
n_nodes = length(sc);

% empty array for storing the community labels
Ci = zeros(n_nodes,num_iter);

% run the community detection algorithm num_iter times
for iter = 1:num_iter
  Ci(:,iter) = community_louvain(sc);
end

% calculate the module coassignment matrix -- for every pair of nodes
% how many times were they assigned to the same community
Coassignment = agreement(Ci)/num_iter;

% node we use the consensus clustering function
thr = 0.5;
cicon_sc = consensus_und(Coassignment,thr,num_iter);

degrees = degrees_und(sc);
f = figure;
scatter3(node_coor(:,1),node_coor(:,2),node_coor(:,3),degrees,cicon_sc,'o','filled');
axis image;

%% Exercise 6
% Repeat the above exercise but using functional connectivity instead of
% structural connectivity. Note that the fc matrix has negative weights
% (anticorrelations). For networks with negative weights you need to modify
% the community_louvain() function. Rather than calling it as:
%
% >> [ci,q] = community_louvain(CIJ);
%
% you should write:
% >> [ci,q] = community_louvain(CIJ,[],[],'negative_asym');
%
% Make sure that you update the code to include these additional arguments.

% number of times to repeat community detection algorithm
num_iter = 100;

% number of nodes
n_nodes = length(fc);

% empty array for storing the community labels
Ci = zeros(n_nodes,num_iter);

% run the community detection algorithm num_iter times
for iter = 1:num_iter
  Ci(:,iter) = community_louvain(fc,[],[],'negative_asym');
end

% calculate the module coassignment matrix -- for every pair of nodes
% how many times were they assigned to the same community
Coassignment = agreement(Ci)/num_iter;

% node we use the consensus clustering function
thr = 0.5;
cicon_fc = consensus_und(Coassignment,thr,num_iter);

degrees = degrees_und(sc);
f = figure;
scatter3(node_coor(:,1),node_coor(:,2),node_coor(:,3),degrees,cicon_fc,'o','filled');
axis image;

%% Exercise 7
% After obtaining communities, a common secondary analysis involves
% calculating nodes' "participation coefficients", which measures whether a
% node's connections are concentrated within or distributed across
% communities. Nodes with high participation are considered polyfunctional
% and act as bridges, relaying signals across modular boundaries.
%
% Use the functions "participation_coef" and "participation_coef_sign" and
% the communities estimated in Exercises 5 and 6 to estimate the
% participation coefficent for each node. Then uses the scatter3() function
% to draw nodes in anatomical space with their colors proportional to
% participation coefficient. Type "help participation_coef" to learn more
% about how to use these functions.
%
% How similar are nodes participation coefficients when estimated using
% stuructural versus functional networks? Use the "corr" function to
% calculate the linear correlation between structural and functional
% participation coefficients. Large correlations coefficients (near 1)
% indicate highly similar participation; values close to zero (or even -1)
% indicate poor correspondence.
%
% NOTE: When you apply this technique to the functional connectivity
% network, you need to use the "sign" version of the
% "participation_coefficient" function (because that network contains
% signed edges).

pc_sc = participation_coef(sc,cicon_sc);
pc_fc = participation_coef_sign(fc,cicon_fc);

f = figure;
scatter3(node_coor(:,1),node_coor(:,2),node_coor(:,3),degrees,pc_sc,'o','filled');
axis image;

f = figure;
scatter3(node_coor(:,1),node_coor(:,2),node_coor(:,3),degrees,pc_fc,'o','filled');
axis image;

rho = corr(pc_sc,pc_fc);

%% Exercise 8
% The Louvain algorithm has a free parameter, gamma, whose value
% determines the number of communities detected -- if gamma is big, then
% the algorithm detects many small communities; if gamma is small then the
% algorithm detects a few big communities. The 'default' value is gamma = 1. 
% 
% You can change the value of the gamma by including a second input
% argument. For instance:
%
% >> gamma = 1.5;
% >> [ci,q] = community_louvain(sc,gamma); % for structural connectivity
% >> [ci,q] = community_louvain(fc,gamma,[],'negative_asym'); % for functional connectivity
%
% The above lines run Louvain algorithm with gamma = 1.5.
%
% Run community detection for the functional connectivity matrix with a few
% different values of gamma (keep gamma within the range of 0.75 and 4). Of
% the values you ran, which one generates communities most similar to the
% "system_labels," a set of communities generated by Alex Schaefer and
% Thomas Yeo in their 2018 paper.
%
% To measure similarity, you will need to use the function
% "partition_distance". As input, you give it two sets of communities, e.g.
% "ci" and "system_labels", and it returns a measure of how distant those
% two partitions are from one another. What does a distance of 0 mean? What
% does a distance of 1 mean? At which gamma value were the consensus
% communities most similar to "system_labels"?
%
% NOTE: To speed things up, you might reduce the number of iterations from
% 100 to, say, 10.

num_iter = 10;

gammavalues = 0.25:0.25:4;

PD = zeros(num_iter,length(gammavalues));
for i = 1:length(gammavalues)
    for iter = 1:num_iter
        Ci = community_louvain(fc,gammavalues(i),[],'negative_asym');
        PD(iter,i) = partition_distance(Ci,system_labels);
    end
end

%% Exercise 9
% Rich-club structure refers to groups of highly connected nodes that are
% also highly connected to one another. Adapt the code from the github
% repository to determine whether there is a rich club at k = 45.
%
% Use the scatter3() command to plot brain nodes in anatomical space with
% node color proportional to degree and color indicative of whether a node
% is or is not part of the rich club.
%
% HINT: The line "rcidx = degrees > k" generates vector of 0's and 1's of
% dimensions equal to [Number of nodes x 1]. A value of 1 indicates that a
% node is a member of the rich-club; a of 0 indicates that a node is not
% part of a rich-club.

% binarize network
scbin = +(sc ~= 0);

% target degree
k = 40;

% calculate nodes' degrees
degrees = degrees_und(scbin);

% get sub-network
idx = degrees > k;
scbinsub = scbin(idx,idx);

% get density
phi = density_und(scbinsub);

% generate randomized networks
nrand = 100; % number of randomized networks
nswaps = 32; % number of times each edge is "rewired" on average
for irand = 1:nrand
  scbinrand = randmio_und(scbin,nswaps);
  scbinrandsub = scbinrand(idx,idx);
  phirand(irand) = density_und(scbinrandsub);
end

% calculate p-value
p = mean(phirand >= phi);

% calculate normalized coefficient
phinorm = mean(phi./phirand);

degrees = degrees_und(sc);
f = figure;
scatter3(node_coor(:,1),node_coor(:,2),node_coor(:,3),degrees,idx,'o','filled');
axis image;

%% Exercise 10
% How are rich-club members distributed across communities? Are they
% concentrated within a single community or spread out over many?
% 
% Generate consensus communities (for the functional network) with gamma 
% equal to the value at which communities were closest to "system_labels" 
% (see Exercise 8). Then, use "rcidx" from Exercise 9 to obtain a list of
% community labels for only rich-club members. Finally, count the number of
% times that each label appears among that list.
%
% HINT: You may find it useful to use the hist() function. Type "help hist"
% in the command line to learn more about the inputs and outputs for that
% function.
%
% HINT: To obtain the list of communities, remember that "rcidx" is 1 for
% all rich nodes. Can you find a way to index within the vector of
% consensus communities such that the only values you return are those
% where rcidx = 1?

gamma = 1.25;

% number of times to repeat community detection algorithm
num_iter = 100;

% number of nodes
n_nodes = length(fc);

% empty array for storing the community labels
Ci = zeros(n_nodes,num_iter);

% run the community detection algorithm num_iter times
for iter = 1:num_iter
  Ci(:,iter) = community_louvain(fc,gamma,[],'negative_asym');
end

% calculate the module coassignment matrix -- for every pair of nodes
% how many times were they assigned to the same community
Coassignment = agreement(Ci)/num_iter;

% node we use the consensus clustering function
thr = 0.5;
cicon = consensus_und(Coassignment,thr,num_iter);

% rich club membership
rcidx = degrees > k;

% community breakdown
h = hist(cicon(rcidx),1:max(cicon));
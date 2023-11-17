clear all
close all
clc

path_to_bct = '/Users/rickbetzel/Brain networks lab Dropbox/bnbl_main/code/startup_code/BCT';
addpath(path_to_bct);

%% Instructions
% In this assignment, you'll load in a network dataset and perform an
% analysis of the network's properties.
%
% A few important points! 
% 1. Instructions for carrying out most of these analyses are already on
%    the course github page (https://github.com/brain-networks/PSY-P457).
% 2. To complete this assignment, you'll need to download a new network
%    from that same URL. You can do this by navigating your web browser to
%    the github repository, clicking on "data", selecting the file
%    "starwars_network.mat" (click the box to the left of its name), and
%    the clicking the download arrow that appears in the bottom right-hand
%    corner. You can move that file into any folder you like. I suggest
%    moving it into the "data" folder where the other course datasets live.
% 3. This network dataset comes from the Star Wars franchise. Nodes are
%    characters and the connection weights are the number of times
%    characters appear in the same scene together.

%% Exercise 1
% Before you load the file "starwars_network.mat" into MATLAB, change your
% "Current Folder" in MATLAB so that you're in the same folder where the
% file "starwars_network.mat" is located. Click once on file (don't load
% it). You should see a tab with file "details" appear (if you do not, then
% right+click on the file and select "Show Details". In the space below,
% tell me how many variables are stored in the file and their names.

% it contains the variables A, col, and name

%% Exercise 2
% Modify the example code from the github page so that you load in the file
% "starwars_network.mat".

% load in data
load('../data/starwars_network.mat');

%% Exercise 3
% Modify the visualization code from the github page so that you plot the
% connectivity matrix using the "imagesc" command. Add a comment (starting
% with the symbol '%') that explains what the colors in the plot represent.

f = figure;
imagesc(A);

% colors indicate the weights of connections -- brighter = stronger, cooler
% = weaker.

%% Exercise 4
% Modify the visualization code and create a graph object for your
% connectivity matrix. Then plot it.

g = graph(A);
f = figure;
ph = plot(g);

%% Exercise 5
% Now, let's embellish our plot. Let's:
% 1. Add labels to each node so that we know what character it represents,
% 2. change nodes' colors (the variable 'col' corresponds to RGB values;
%    we'll use them),
% 3. Change the size of nodes so that size is proportional to degree, and
% 4. Make line thickness proportional to edge weight.
% 
% We can plot our network with the command:
% 
% >> plot(g);
%
% To change properties, we need to add input argument pairs. The first
% input is always a string -- it tells MATLAB what it is you want to
% change. The second input is the values to which you're changing it. So a
% typical command would look like this:
%
% >> plot(g,'PROPERTY1',New_Value,'PROPERTY2',Another_New_Value);
%
% Note that here I specified more than one property to change. Below are
% the pairs that you need to include as inputs:
%
% Property name: 'NodeLabel'
% Property value: name
%
% Property name: 'NodeColor'
% Property value: col
%
% Property name: 'MarkerSize'
% Property value: (degrees_und(A) + 1)/3
%
% Property name: 'LineWidth'
% Property value: (g.Edges.Weight)/5
%
% Property name: 'NodeCData'
% Property value: cicon
%

f = figure;
ph = plot(g,...
    'nodelabel',name,...
    'nodecolor',col,...
    'markersize',(degrees_und(A) + 1)/3,...
    'linewidth',g.Edges.Weight/5);

%% Exercise 6
% What happens if you change the value of 'MarkerSize' from (degrees_und(A)
% + 1)/3 to simply (degrees_und(A) + 1)?
%
% Why do you think we need to add + 1 to nodes' degrees? HINT: Why is there
% an isolated node in the plot?
%
% Write your answers below.

% Dividing by three makes the size 3 times smaller; if we omit that then we
% get very large markers (nodes).

% We need to add 1 to degree because of the isolated node. It's degree is
% zero and we can't plot nodes of size 0.

%% Exercise 7
% Modify the example code on the course github page to estimate consensus
% communities.

niter = 100;
ci = zeros(length(A),niter);
for iter = 1:niter
    ci(:,iter) = community_louvain(A);
end

coassignment = agreement(ci)/niter;
thr = 0.5;
cicon = consensus_und(coassignment,thr,niter);

%% Exercise 8
% Plot the network again, but change nodes' colors so that they depict
% community label. That is, change the plot so that all nodes in the same
% community have the same color.

f = figure;
ph = plot(g,...
    'nodelabel',name,...
    'NodeFontSize',5,...
    'nodecdata',cicon,...
    'markersize',(degrees_und(A) + 1)/3,...
    'linewidth',g.Edges.Weight/5);

%% Exercise 9
% Which nodes have the greatest degree? Modify code from the github page to
% calculate node degree. Then use the 'maxk' function with k = 5 to
% identify the five nodes with the greatest degree. Note that if you only
% ask for one output argument, you'll get the biggest degrees but not the
% node indices. Once you have the indices, you can find the corresponding
% elements in the 'name' array to figure out which characters those indices
% correspond to.

deg = degrees_und(A);

k = 5;
[deg_max,idx_max] = maxk(deg,k);

disp(name(idx_max));
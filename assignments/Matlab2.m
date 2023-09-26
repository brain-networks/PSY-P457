clear all
close all
clc

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



%% Exercise 2
% Modify the example code from the github page so that you load in the file
% "starwars_network.mat".



%% Exercise 3
% Modify the visualization code from the github page so that you plot the
% connectivity matrix using the "imagesc" command. Add a comment (starting
% with the symbol '%') that explains what the colors in the plot represent.



%% Exercise 4
% Modify the visualization code and create a graph object for your
% connectivity matrix. Then plot it.



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



%% Exercise 6
% What happens if you change the value of 'MarkerSize' from (degrees_und(A)
% + 1)/3 to simply (degrees_und(A) + 1)?
%
% Why do you think we need to add + 1 to nodes' degrees? HINT: Why is there
% an isolated node in the plot?
%
% Write your answers below.



%% Exercise 7
% Modify the example code on the course github page to estimate consensus
% communities.



%% Exercise 8
% Plot the network again, but change nodes' colors so that they depict
% community label. That is, change the plot so that all nodes in the same
% community have the same color.



%% Exercise 9
% Which nodes have the greatest degree? Modify code from the github page to
% calculate node degree. Then use the 'maxk' function with k = 5 to
% identify the five nodes with the greatest degree. Note that if you only
% ask for one output argument, you'll get the biggest degrees but not the
% node indices. Once you have the indices, you can find the corresponding
% elements in the 'name' array to figure out which characters those indices
% correspond to.



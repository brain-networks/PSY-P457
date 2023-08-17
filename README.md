# PSY-P457 Code, data, and examples
This repository contains data, code, and assignments for students enrolled in PSY-P457: Networks in the psychological, cognitive, and brain sciences.

To make your lives easier, I have included a few examples where I illustrate how to perform some basic operations.

## 1. How do I load connectivity data?
Datasets that we need for the course are in the <code>data/</code> directory and, unless noted otherwise, stored as <code>.mat</code> files. This file type is specific to MATLAB--you can think of <code>.mat</code> files as bags or boxes in which many variables, including connectivity data, can be stored. When we load a <code>.mat</code> file, we are loading many variables into our workspace.

By default, the datasets included in <code>data/</code> come from the Brain Connectivity Toolbox. Once you've cloned or downloaded this repository, you can create all of your scripts in the <code>m</code> directory. Right now, that directory is empty. If we wanted to load data from a script located in <code>m</code>, we'd write something like:

```Matlab
# load a .mat file from a specific location
load('../mat/Coactivation_matrix.mat')
```

Note here that the <code>../mat/</code> tells MATLAB to go navigate to one directory higher than <code>m</code> and then into the <code>mat</code> directory. It then specifies the exact file to load. In this case, it's one named <code>Coactivation_matrix.mat</code>. If you replaced <code>Coactivation_matrix.mat</code> with <code>mac95.mat</code> then you'd load a different <code>.mat</code> file.

It is also critical that you specify the correct path to the file you're trying to load. For instance, if you wrote:

```Matlab
# load a .mat file from a specific location
load('../directory_x/Coactivation_matrix.mat')
```

and <code>directory_x</code> doesn't exist, then the above command would return an error.

## 2. How do I calculate the number of nodes and connections in my network?
Suppose you've already loaded some data using syntax borrowed from the previous section. Let's also suppose that the variable <code>Cij</code> denotes your connectivity matrix. If we wanted to calculate the number of nodes and connections in the network (irrespective of their weights), we could write the following:

```Matlab
# calculate number of nodes
n_nodes = length(Cij);

# calculate the number of nonzero entries in the matrix
n_edges = nnz(Cij);

# calculate the density of connections (fraction of existing edges divided by total number possible)
dens = density_und(Cij); # <- if your network is undirected
dens = density_dir(Cij); # <- if your network is directed
```

## 3. How do I calculate the number of connections each node makes?
The number of connections a node makes is referred to as its degree. For directed networks, we can further break down this number by parsing degree into the number of incoming and outgoing connections. If we wanted to calculate nodes' degrees, we could use the following functions:

```Matlab
# calculate incoming/outgoing/total degree for each node in a directed network
[degree_in,degree_out,degree_tot] = degrees_dir(Cij);

# do the same for nodes in an undirected network
degrees = degrees_und(Cij);
```
## 4. How do I calculate global measures like characteristic path length and efficiency?
The simplest way to do this for any network is to calculate the shortest paths matrix between all pairs of nodes. Again, supposing our connectivity matrix is <code>Cij</code>, we would write the following:

```Matlab
# calculate distance matrix
D = distance_bin(Cij);

# calculate binary path length and efficiency
[lambda,efficiency] = charpath(D);
```

In the above lines, <code>lambda</code> and <code>efficiency</code> are the path length and efficiency of the network.

The above procedure works for a binary network where edges are either 1 or 0. For weighted networks, we can do something similar, but have to first convert our edge weights from measures of affinity (how much two nodes ``like'' one another) to how costly each edge is. We can do that like so:

```Matlab
# transform weights into costs via an inversion
Cost = 1./Cij;

# calculate weighted distance matrix
D_wei = distance_wei(Cost);

# calculate weighted path length and efficiency
[lambda_wei,efficiency_wei] = charpath(D);
```

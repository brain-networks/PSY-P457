# PSY-P457 Code, data, and examples
This repository contains data, code, and assignments for students enrolled in PSY-P457: Networks in the psychological, cognitive, and brain sciences.

To make your lives easier, I have included a few examples where I illustrate how to perform some basic operations.

## How do I load connectivity data?
Datasets that we need for the course are in the <code>data/</code> directory and, unless noted otherwise, stored as <code>.mat</code> files. This file type is specific to MATLAB--you can think of <code>.mat</code> files as bags or boxes in which many variables, including connectivity data, can be stored. When we load a <code>.mat</code> file, we are loading many variables into our workspace.

By default, the datasets included in <code>data/</code> come from the Brain Connectivity Toolbox. Once you've cloned or downloaded this repository, you can create all of your scripts in the <code>m</code> directory. Right now, that directory is empty. If we wanted to load data from a script located in <code>m</code>, we'd write something like:

<code>load('../mat/Coactivation_matrix.mat')</code>/

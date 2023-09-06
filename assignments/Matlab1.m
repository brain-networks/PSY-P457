clear all
close all
clc

%%  Introduction and instructions
% This assignment serves as an introduction to Matlab and some of the its
%   basic functionality. The assignment is divided into several sections.
%   You are expected to write your answers in the blanks. Sometimes your
%   answers need to be Matlab code. If you write Matlab code, you must also
%   include a comment indicating what the code is doing. This is a good
%   habit to develop -- when you add comments, it makes it possible for
%   others to understand how your code is supposed to work. It also makes
%   it possible for you to come back to your code later and remember what
%   you were working on. For example, if you were asked to calculate the
%   sum of 3 and 5 and store the answer in a variable 'x', you would write:
%
%    x = 3 + 5;       % calculate the sum of 3 + 5
%
% Notice: any text after symbol '%' turns green. Green text will not be
%   executed by Matlab. Any notes or comments should always start with the
%   '%' symbol. Any text that appears black Matlab thinks is executable
%   code and it will try to run.


%%  Section #1.
% In it's most basic form, Matlab is a calculator. It can do addition,
%   subtraction, division and multiplication (using the symbols '+', '-', 
%   '/', and '*'. In the space calculate 6 times 3, 2 plus 44, 11.4 - pi,
%   and 101 divided by 31.


%%  Section #2.
% One of the things about Matlab that distinguishes it from a calculator
%   is that it can store multiple variables at the same time as long as
%   they have different variable names. Every time you perfrom some
%   operation with Matlab, you can assign the result a different namee. For
%   instance, suppose I wanted to calculate 10 times30 and keep track of 
%   the result. I could write:
%
%       m = 10*30;
%
% Now your workspace should include a variable named 'm' whose value is
%   equal to 300.
%
% Repeat the four operations you performed in the previous section, but
%   assign the answers the variable names 'a', 'b', 'c', and 'd'.
%


%%  Section #3.
% You can use parentheses to specify order of operations. For instance,
%   if I ran the code:
%
%       x = 101 + 2*3;
%
% Matlab will first calculate 2*3 and add that to 101. But if I wrote:
%
%       x = (101 + 2)*3;
%
% Then Matlab would first calculate 101 + 2 and multiple 103 times 3.
%
% Add parantheses to the following expression so that the answer becomes 
%   18.

x = 3*5 + 1;


%%  Section #4.
% Once you've created some variables, you can perform operations using
%   the variable names. For instance:
%
%       a = 10;
%       b = 31;
%       c = a/b;
%
% The value of c is equal to 10 divided by 31 (or about 0.3226).
%
% Create a new variable named 'y' whose value is equal to the variable
%   'x' from the previous section divided by 3.


%%  Section #5.
% You'll notice that I've been typing a semi-colon after each line of
%   code. Assign the value 6 to a variable 'm'. Do this twice -- once with
%   a semi-colon and another time without a semi-colon. What does the
%   semi-colon do? (you'll need to run the code to determine this).


%%  Section #6.
% Earlier you calculated a variable 'y' that was equal to 'x' divided by
%   3. Assign the value of 20 to 'x'. Does this change the value of 'y'? In
%   your own words, explain why this is.
%


%%  Section #7. 
% So far you've just worked with individual numbers. In Matlab, these
%   numbers are considered arrays. Individual numbers are arrays with 1
%   element, but arrays can in general be much larger and of any
%   dimensions. Start, here, by clearing all the variables in the workspace
%   (look back at our slides from Week 2, Lecture 1 for an explanation on
%   how to do this). Then create a variabled named 'x' with value equal to
%   4.


%%  Section #8.
% If you want to create a bigger array, you need to use brackets, '[]'.
%   All the elements of the array go between the brackets. For example, the
%   code:
%
%  x = [3,5];
%
% would create an array containing the values 3 and 5.
% Create an array named 'my_array' containing the numbers, 10, 1005, and 
%   -15.


%%  Section #9.
% When you separate numbers in an array by commas (as in the previous
%   section) you create a row array -- all the elements are in the same
%   row. When you separate numbers by semi-colons, you create a column
%   array -- all the elements of the array are in the same column. Create a
%   column array with the numbers 25, -15, and 6.


%%  Section #10.
% You arrays can be much larger and contain multiple columns. For
%   instance:
%
% x = [3,4,5;6,7,8];
%
% Create a matrix named 'big_matrix' that has two columns and three rows,
%   where the first row contains the numbers 3, 23, the second row contains
%   the numbers 13 and 17, and the third row contains the numbers 5 and 11.


%%  Section #11.
% You can create evenly-spaced vectors using the ':' command. If you
%   write:
%
%   x = 7:11;
%
% Matlab will create a variable named 'x' with the values [7,8,9,10,11].
%   Create an array 'y' using the ':' command that contains the numbers 1 
%   through 21.


%% Section #12.
% The default spacing is 1, but you can change that. For instance, you
%   could change the spacing to be 2. For instance:
% 
% x = 7:2:11;
%
% Create an array 'y' using the ':' command that contains the numbers 1 
%   through 21 in increments of 0.5.

%%  Section #13.
% You can extract values of an array using row and column indexing. The
%   code below extracts the element of the 5th row and 3rd column from the
%   array 'x'. Modify this code to extract the value of the 3rd row and 2nd column.

x = [1, 5,  6;          % create a 5 x 3 array
     13,pi, 3;
     2, 15, 29;
     101, 2,  4
     0.3,   11, 131];
y = x(5,3);             % extract fifth row and third column

%%  Section #14.
% You can extract multiple elements at once using the ':' command. For 
%   instance:
%
%   a = x(:,3);
%
% would extract all of the elements in the third column and assign them
%   to a variable 'a'.
% Create a new variable named 'x2' that includes all of the elements in 
%   the second row of the array 'x' from the previous section.


%%  Section #15.
% You can also specify the range of elements to extract. For instance:
%   
% b = x(1:4,3);
%   would extract the elements in first four rows and in the third column.
%   
% Create a new variable named 'x3' that includes values in the first two
%   rows and first two columns.


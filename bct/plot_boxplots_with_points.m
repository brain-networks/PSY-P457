function plot_boxplots_with_points(data_cell)
% data_cell: A cell array containing the datasets as column vectors

% Concatenate all datasets into a single vector
data_all = vertcat(data_cell{:});

% Create a grouping vector to associate each data point with its respective dataset
group = arrayfun(@(i) i * ones(size(data_cell{i})), 1:numel(data_cell), 'UniformOutput', false);
group_all = vertcat(group{:});

% Create a boxplot
figure;
boxplot(data_all, group_all, 'Notch', 'on');
hold on;

% Calculate the x-axis position for each dataset
x_positions = 1:numel(data_cell);

% Overlay individual data points on the boxplots
for i = 1:numel(data_cell)
    x = x_positions(i) * ones(size(data_cell{i})) + (rand(size(data_cell{i})) - 0.5) * 0.1; % Add jitter for better visibility
    y = data_cell{i};
    plot(x, y, 'k.', 'MarkerSize', 10);
end

% Customize the appearance of the graph (optional)
title('Boxplots with Data Points');
xlabel('Distributions');
ylabel('Values');
xticks(x_positions);
xticklabels(1:numel(data_cell));
xlim([0.5, numel(data_cell) + 0.5]);

% Release the hold on the current figure
hold off;

end


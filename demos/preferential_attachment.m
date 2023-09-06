%% Hubs and rich clubs
% Many real-world networks exhibit heavy-tailed degree distributions,
% suggesting that there are a small number of nodes that make
% disproportionately more connections than others. Often, these same nodes
% form a "rich club", connecting more densely to one another than expected
% by chance.
%
% One of the first models of how hubs emerge was the Barabasi-Albert model,
% that used a preferential attachment mechanism in a growth model to
% generate synthetic networks with heavy-tailed degree distributions. Let's
% implement the model here before turning to real-world data to detect
% hubs.

% initial clique size
k = 5;

% target network size
n = 1000;

% when a new node is added, how many new connections to form
m = 2;

% create initial adjacency matrix
a = sparse([],[],n,n,0);
a(1:k,1:k) = 1;
a(1:(n + 1):end) = 0;

% degree
deg = sum(a,2);

% grow the network
for i = (k + 1):n
    
    % connection probability distribution
    c = [0; cumsum(deg)];
    count = 0;
    
    % add connections
    while count < m
        
        % get a partner
        partner = sum(rand*c(end) > c);
        
        % if proposed connection doesn't exist...
        if a(i,partner) == 0
            
            % add connection
            a(i,partner) = 1;
            a(partner,i) = 1;
            
            % update degree
            deg([i,partner]) = deg([i,partner]) + 1;
            
            % update counter
            count = count + 1;
        end
    end
end

% calculate degree distribution
[h,bins] = hist(deg,1:max(deg));

% plot degree distribution
f = figure('units','inches','position',[2,2,4,2]);
plot(log10(bins(h ~= 0)),log10(h(h ~= 0)),'-o')
xlabel('log10 degree');
ylabel('log10 count');
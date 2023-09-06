%% The Watts-Strogatz model
% The the WS model starts with a lattice network and, with a small
% probability, $p$, adds noise to network via random rewirings. Let's start
% by constructing a lattice. Here, the parameter $k$ is the number of
% nearest neighbors each node is connected to.

% number of nodes
n = 1000;

% number of nearest neighbors
k = 10;

% connectivity matrix
a = zeros(n);

% wire up the network
for i = 1:n
    idx = (i - k):(i + k);
    idx = mod(idx,n);
    idx(idx == 0) = n;
    a(i,idx) = 1;
end

% remove self connections
a(1:(n + 1):end) = 0;

% calculate clustering
c0 = mean(clustering_coef_bu(a));

% calculate shortest paths matrix
spl0 = distance_bin(a);

% calculate characteristic path length
l0 = charpath(spl0);

% rewiring probability
p = logspace(-5,0,31);

% preallocate arrays for storying clustering and path length
c = zeros(length(p),1);
l = c;

% edge list
[ue,ve] = find(triu(a,1));

% empty edges
[xe,ye] = find(triu(a == 0,1));

% loop over rewiring probabilities
for i = 1:length(p)
    
    disp(i);
    
    % mask of edges to rewire
    r = find(rand(size(ue)) < p(i));
    
    
    % loop over edges
    for j = 1:length(r)
        
        s = randi(length(xe));
        
        u = ue(r(j));
        v = ve(r(j));
        
        x = xe(s);
        y = ye(s);
        
        ue(r(j)) = x;
        ve(r(j)) = y;
        
        xe(s) = u;
        ye(s) = v;
        
    end
    
    edges = (ue - 1)*n + ve;
    a = zeros(n);
    a(edges) = 1;
    a = a + a';
    
    % calculate clustering and path length
    c(i) = mean(clustering_coef_bu(a));
    spl = distance_bin(a);
    l(i) = charpath(spl);
end

% make figure
f = figure('units','inches','position',[2,2,4,2]);
ph = plot(log10(p),c/c0,log10(p),l/l0);
set(ph,'marker','o');
leg = legend(ph,{'c/c0','l/l0'});
xlabel('log10 rewiring probability');
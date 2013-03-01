
function [ReducedX]     = PCA(Data, NewDim)
p       = Data;
M       = NewDim;

[v,d]   = eig(cov(p));
d       = diag(d);
u = [];

% subtract the mean
mn      = mean(p,1);
p       = p - repmat(mn, [size(p,1) 1]);
% keyboard
for i=1:M
    [c,idx]  = max(d);
    % remove that column since we have already used it up
    d(idx,:) = [];
    % get the eigenvectors
    u        =[u v(:,idx)];
end
% keyboard
y           = p*u;
ReducedX    = y;
end

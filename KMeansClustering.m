function [Means, NewAssignment]        = KMeansClustering(Data, KMeans, Dim, NoOfElements)
N   = NoOfElements;
K   = KMeans;
D   = Dim;
X   = Data;

% Align the data in N x Dim format
if size(X,2) == Dim
    X = X;
else
    X = X';
end

OldR = ones([N K]);   %To store the previous value of R, for comparison
R = zeros([N K]);

% Initialize Mu to random points
Mu = zeros([K D]);
for i   = 1:K
    Mu(i,:) = X(randi(K,1),:);
end

while ~isequal(R,OldR) %Continue while the regrouping is different from previous iteration
    %Retain old value of R
    OldR = R;
    
    %Reinitialize R
    R = zeros([N K]);
    
    % Keep Mu fixed
    for n=1:N
        d = repmat(X(n,:),[K 1]) - Mu;      %Subtract all the Mu from a single vector
        e = sum(d.*d,2);                    %Square the term and add for getting the norm^2
        [value index] = min(e);             %Get the minimum value, the Column/Row is stored in index
        R(n,index) = 1;                     %Make corresponding R(n,k) = 1
    end
    
    %Keep R(n,k) fixed
    SumR = sum(R,1);                   %Sum of each column - for denominator
    Mu = (X'*R)'./repmat(SumR',[1 D]);
    %     fprintf('Mu: %d\n', Mu);
end
% keyboard

[val,NewX] = (max(R,[],2));
Means  = Mu;
NewAssignment = NewX;
end
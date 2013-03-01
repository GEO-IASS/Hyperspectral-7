function [Means, NewAssignment] = FuzzyCMeans(Data, KMeans, Dim, NoOfElements, M)
N   = NoOfElements;
K   = KMeans;
D   = Dim;
X   = Data;
m   = M;

% Align the data in N x Dim format
if size(X,2) == Dim
    X = X;
else
    X = X';
end

OldC = ones([N K]);   %To store the previous value of R, for comparison
C = zeros([N K]);

% Initialize Mu to random points
Mu = zeros([K D]);
for i   = 1:K
    Mu(i,:) = X(randi(K,1),:);
end

norm(C-OldC)/norm(OldC)
while (norm(C-OldC)/norm(OldC) > 1e-5) %Continue while the regrouping is different from previous iteration, unless I am (1 - 0.000001 = 0.999999 or 99.99999% sure that it belongs to this cluster), change this value to see how it behave otherwise
    %Retain old value of C
    OldC = C;
    
    %Reinitialize C
    C = zeros([N K]);
    
    % Keep Mu fixed
    for n=1:N
        d = repmat(X(n,:),[K 1]) - Mu + eps*ones(size(Mu));      %Subtract all the Mu from a single vector
        e = (sum(d.*d,2).^(-1/(m-1)));                    %Square the term and add for getting the norm^2

        C(n,:)   = e'./sum(e);
    end
    
    %Keep C(n,k) fixed
    SumC = sum(C,1);                   %Sum of each column - for denominator
    Mu = (X'*C)'./repmat(SumC',[1 D]);
    norm(C-OldC)/norm(OldC)
end

NewX = C;
Means  = Mu;
NewAssignment = NewX;
end
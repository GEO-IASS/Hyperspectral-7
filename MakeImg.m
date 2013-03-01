[Pn1,X1] = FuzzyCMeans(P,KM,Dim,size(NewD,1),2);

% keyboard
j  = 1;
y       = zeros(145,145);
y1      = zeros(145,145);
for i  = 1:145
%     y(:,i) = X1(j:i*145);
    y1(:,i) = X1(j:i*145);
    j = i*145 + 1;
end

load HSIGroundTruth.mat;
subplot(1,2,1); imagesc(IPGT); title('Ground Truth');
subplot(1,2,2); imagesc(y1'); title('K = 5');
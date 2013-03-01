function [NewData]      = Convert3Dto2D(Data, Orient)
x   = Data;
p=[];
if Orient == 1
    for i   = 1:size(x,1)
        p   = [p x(i,:,:)];
    end
elseif Orient == 2
    for i   =1:size(x,2)
        p   = [p x(:,i,:)];
    end
elseif Orient == 3
    for i   =1:size(x,3)
        p   = [p x(:,:,i)];
    end
end

p       = squeeze(p);
NewData = p;
end

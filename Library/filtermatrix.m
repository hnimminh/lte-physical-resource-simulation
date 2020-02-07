function H=filtermatrix(matrix,ia,iz,ja,jz)
%% DEVERLOPER-PROGRAMMER: NGUYEN HOANG MINH
% M=fillmatrix(matrix,ia,iz,ja,jz
% Lay matran con trong matran
% ia :hang lay dau - iz hang lay cuoi
% ja :cot lay dau - jz cot lay cuoi


s=size(matrix);         %s=[s1 s2]| s(1)=hang s(2)=cot

H=matrix;
if jz < s(2)
    for j=1:s(2)-jz
        H(:,jz+1)=[];
    end
end
if ja > 1
    for j=1:ja-1
        H(:,1)=[];
    end
end

if iz < s(1)
    for i=1:s(1)-iz
        H(iz+1,:)=[];
    end
end
if ia > 1
    for i=1:ia-1
        H(1,:)=[];
    end
end

end
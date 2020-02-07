function q=strematrix(I,p)
%% DEVERLOPER: NGUYEN HOANG MINH
% q=strematrix(I,p)
% strematrix = StaticTis Resource Element of MATRIX
% liet ke so lan suat hien phan tu p trong matran I
% I matran chua phan tu can tim 
% p phan tu can tim
% q so phan tu p chua trong I

s=size(I); %s(1) = hang     s(2)=cot
q=0;                    
    for i=1:s(1)
        for j=1:s(2)
            if I(i,j)==p
            q=q+1;
            end
        end
    end
    
    if p==0,q=q-1;end
    if q<1,q=0;end
    
end
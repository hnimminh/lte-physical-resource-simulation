function M=turnmatrix(A)
%% DEVERLOPER: NGUYEN HAONG MINH
% M=turnmatrix(A)
% DAO HANG MA TRAN
M=A;
msize=size(A);hang=msize(1);cot=msize(2);
for i=1:1:hang
    for j=1:1:cot
    M(i,j)=A(hang+1-i,j);
    end
end
end
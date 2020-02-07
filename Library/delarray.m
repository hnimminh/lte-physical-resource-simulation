function m=delarray(array,value)
% DEVERLOPER: NGUYEN HOANG MINH
% DELETE ELEMENT OF SINGLE ARRAY
% XOA PHAN TU TRONG MANG 1 CHIEU
% VALUE : GIA TRI CAN XOA CHO MANG ARRAY

l=length(array);m=[];
    for i=1:l 
        if array(i)~=value, 
            m=[m array(i)];
        end
    end
end


function string = data2string(data)
%% DEVELOPER: NGUYEN HOANG MINH
%  CONVERT ALL TYPE DATA TO STRING ONLY USED WITH LTE PROJECT

    string =  num2str(data);
    if  data==0, string = 'N/A';end
    
end
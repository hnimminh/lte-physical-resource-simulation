function map = minhcolor(m)
% DEVERLOPER NGUYEN HOANG MINH, LTE PROJECT
% MAPCOLOR : > 4BIT=20TYPE COLOR
% REFERENCE FROM: C. Moler, Copyright 1984-2004 The MathWorks, Inc.

%F = [1 1 1;1 1 0;1 0 1;0 0 0;0 0 1;0 1 0;1 0 0;.5 .5 .5;0 1 1;.5 .5 0;1 1 .5;1 .5 0;.5 0 1;1 0 .5;0 .3 0;0 1 .5;.3 0 0;0 .5 1;0 0 .3;.5 1 0];

    M1=[1 1 1];     M2=[1 1 0]; 
    M3=[1 0 1];     M4=[0 0 0];
    M5=[0 0 1];     M6=[0 1 0];
    M7=[1 0 0];     M8=[.5 .5 .5];
    M9=[0 1 1];     M10=[.5 .5 0];
    
    M11=[1 1 .8];      M12=[1 .5 0];
    M13=[.8 0 1];      M14=[1 0 .5];
    M15=[0 .3 0];      M16=[0 1 .7];
    M17=[.3 0 0];      M18=[0 .6 1];
    
    M19=[0 0 .3];      M20=[.5 1 0];

switch m
    case 5, F=[M11; M12; M13; M14; M15];
    case 6, F=[M11; M12; M13; M14; M15; M16];
    case 7, F=[M1; M2; M3; M4; M5; M6; M7;];
    case 8, F=[M1; M2; M3; M4; M5; M6; M7; M8];
    case 10, F = [M1; M2; M3; M4; M5; M6; M7; M8; M9 ;M10];
    case 14, F = [M1; M2; M3; M4; M5; M6; M7; M11; M12; M13; M14; M15; M17; M18];
    case 15.1, F = [M1; M2; M3; M4; M5; M6; M7; M8; M11; M12; M13; M14; M15; M17; M18];
    case 15.2, F = [M1; M2; M3; M4; M5; M6; M7; M11; M12; M13; M14; M15; M16; M17; M18];
    case 16, F = [M1; M2; M3; M4; M5; M6; M7; M8; M11; M12; M13; M14; M15; M16; M17; M18];
    case 17, F = [M1; M2; M3; M4; M5; M6; M7; M8; M9; M10; M11; M12; M13; M14; M15; M17; M18];
    case 18, F = [M1; M2; M3; M4; M5; M6; M7; M8; M9; M10; M11; M12; M13; M14; M15; M16; M17; M18];
    otherwise
    F = [M1; M2; M3; M4; M5; M6; M7; M8; M9; M10; M11; M12; M13; M14; M15; M16; M17; M18; M19; M20];
end
 

if nargin < 1, m = size(get(gcf,'colormap'),1); end

e = ones(ceil(m/4),1);
map = kron(e,F);
map = map(1:m,:);
end
function matrix=lteprgfdduplink(BW,Ncp,Mpfi)
%% DEVERLOPER: NGUYEN HOANG MINH
% matrix=lteprbdownlink(BW,Ncp)
% Matrix of LTE Physical Resource Grid Uplink 

% BW:     Bandwidth of systems [1.4 3 5 10 15 20]
% Ncp:    Number of Cyclic Prefix    Normal=7   Extended=6
% Mpfi:   PUCCH FORMAT INDICATOR 
%% LAP CAC CHI SO CHO LAP MA TRAN

Ncolum=20*Ncp;                          
Nrow=12*5*BW;if BW==1.4, Nrow=12*6;end
M=ones(Nrow,Ncolum);                    %TAO MA TRAN PUSCH

switch BW                               %LAP FREQ LENGTH SOUNDING-RS
    case 1.4,FLsrs=6;
    case 3,FLsrs=15;
    case 5,FLsrs=25;
    case 10,FLsrs=25;
    case 15,FLsrs=25;
    case 20,FLsrs=25;      
end

if BW>=5                                %LAP FREQ LENGTH DAU-CUOI PRACH 
    FLzprach=Nrow-(3*12-1);
    FLaprach=Nrow-((6+3)*12-1);
else
    FLzprach=0;
    FLaprach=0;
end

%% LAP CAC CHI SO CHO DINH DANG CUA PUCCH

switch Mpfi
    case 0
        IDFpfi=0;
        if Ncp==6
            IDDpucch=[1 2 3 5 6];
            IDTpucch=IDDpucch+Ncp;
            IDDdrsc=4;
            IDTdrsc=IDDdrsc+Ncp;
        elseif Ncp==7
            IDDpucch=[1 3 4 5 7];
            IDTpucch=IDDpucch+Ncp;
            IDDdrsc=[2 6];
            IDTdrsc=IDDdrsc+Ncp;
        end
    case 1
        IDFpfi=0;    
        if Ncp==6
            IDTpucch=[1 2 3 5 6];
            IDDpucch=IDTpucch+Ncp;
            IDTdrsc=4;
            IDDdrsc=IDTdrsc+Ncp;
        elseif Ncp==7
            IDTpucch=[1 3 4 5 7];
            IDDpucch=IDTpucch+Ncp;
            IDTdrsc=[2 6];
            IDDdrsc=IDTdrsc+Ncp;
        end
    case 3
        IDFpfi=1;
        if Ncp==6
            IDTpucch=[1 2 5 6];
            IDDpucch=IDTpucch+Ncp;
            IDTdrsc=[3 4];
            IDDdrsc=IDTdrsc+Ncp;
        elseif Ncp==7
            IDTpucch=[1 2 6 7];
            IDDpucch=IDTpucch+Ncp;
            IDTdrsc=[3 4 5];
            IDDdrsc=IDTdrsc+Ncp;
        end        
    case 4
        IDFpfi=2;
        if Ncp==6
            IDDpucch=[1 2 5 6];
            IDTpucch=IDDpucch+Ncp;
            IDDdrsc=[3 4];
            IDTdrsc=IDDdrsc+Ncp;
        elseif Ncp==7
            IDDpucch=[1 2 6 7];
            IDTpucch=IDDpucch+Ncp;
            IDDdrsc=[3 4 5];
            IDTdrsc=IDDdrsc+Ncp;
        end 
    case 5
        IDFpfi=2;
        if Ncp==6
            IDTpucch=[1 2 5 6];
            IDDpucch=IDTpucch+Ncp;
            IDTdrsc=[3 4];
            IDDdrsc=IDTdrsc+Ncp;
        elseif Ncp==7
            IDTpucch=[1 2 6 7];
            IDDpucch=IDTpucch+Ncp;
            IDTdrsc=[3 4 5];
            IDDdrsc=IDTdrsc+Ncp;
        end               
end

    if Ncp==6,IDdrss=3;
    elseif Ncp==7,IDdrss=4;
    end   
    
    
%% PHU TIN HIEU & KENH VAT LY LEN MATRAN
      
%========================   PHU KENH PUCCH 2/2a/2b #1  ===================
    Mpucch=M;
    for k=1:length(IDTpucch)                % PHU PHAN TREN
        h=IDTpucch(k);
        for j=h:2*Ncp:Ncolum
            for i=12*IDFpfi+1:12*IDFpfi+12,Mpucch(i,j)=2;end
        end
    end
    
    for k=1:length(IDDpucch)                % PHU PHAN DUOI
        h=IDDpucch(k);
        for j=h:2*Ncp:Ncolum
            for i=Nrow-(12*IDFpfi+11):Nrow-12*IDFpfi,Mpucch(i,j)=2;end
        end
    end
   
%======================  PHU TIN HIEU D-RS_PUCCH   ========================    
    Mdrsc=Mpucch ;
    for k=1:length(IDTdrsc)                 % PHU PHAN TREN
        h=IDTdrsc(k);
        for j=h:2*Ncp:Ncolum
            for i=12*IDFpfi+1:12*IDFpfi+12,Mdrsc(i,j)=3;end
        end
    end
                                            
    for k=1:length(IDDdrsc)                 % PHU PHAN DUOI
        h=IDDdrsc(k);
        for j=h:2*Ncp:Ncolum
        for i=Nrow-(12*IDFpfi+11):Nrow-12*IDFpfi,Mdrsc(i,j)=3;end
        end
    end
    
%======================  PHU TIN HIEU D-RS_PUSCH   ========================    
    Mdrss=Mdrsc;    
    for i=1:Nrow
        for j=IDdrss:Ncp:Ncolum
        if Mdrss(i,j)==1,Mdrss(i,j)=4;end
        end
    end

%======================  PHU TIN HIEU SOUNDING-RS  ========================
    Msrs=Mdrss;    
    for i=1:FLsrs*12
        for j=Ncp:Ncp:Ncolum
        if Msrs(i,j)==1,Msrs(i,j)=5;end
        end
    end
    
%========================      PHU KENH PRACH      ========================
     Mprach=Msrs;
     if FLzprach > 0
        for i=FLaprach:FLzprach
             for j=1:Ncolum
             if Mprach(i,j)==1,Mprach(i,j)=6;end
             end
        end
     end
%============================    KET THUC    ============================== 
matrix=Mprach;


end

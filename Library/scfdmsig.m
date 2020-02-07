function [t,scfdm]=scfdmsig(Modulation,Nsubcarrier,Nsymbol,SubcarrierMapping,PulseShapingFilter,RolloffFactor)
% DEVERLOPER: NGUYEN HOANG MINH
% Referrence from  SC-FDMA Project  
% Hyung G.Myung [Qualcomm] & David J.Goodman [NYU]
% [t,scfdm]=scfdmsig(Modulation,Nsubcarrier,Nsymbol,SubcarrierMapping,PulseShapingFilter,RolloffFactor)
% plot(t,scfdm);

bw=round(Nsubcarrier/100);if bw<3,bw=1.4;end;
Fs = bw*1e6;Ts = 1/Fs;Nos = 4; 
Qi = Nsubcarrier/Nsymbol;Qd = Qi-1; 

    if strcmp(Modulation,'QPSK')==1
        qpskConstellation = [-1-1j -1+1j 1-1j 1+1j];
        temp = ceil(rand(1,Nsymbol)*4);
        for k = 1:Nsymbol,
            if temp(k) == 0,temp(k) = 1;end
            data(k) = qpskConstellation(temp(k));
        end
    elseif strcmp(Modulation,'16QAM')==1
        qamConstellation = [-3+3i -1+3i 1+3i 3+3i -3+1i -1+1i 1+1i 3+1i -3-1i -1-1i 1-1i 3-1i -3-3i -1-3i 1-3i 3-3i];
        temp = ceil(rand(1,Nsymbol)*16);
        for k = 1:Nsymbol,
            if temp(k) == 0,temp(k) = 1;end
            data(k) = qamConstellation(temp(k));
        end
    elseif strcmp(Modulation,'64QAM')==1
        xi=[-7 -5 -3 -1 1 3 5 7];x=[xi xi xi xi xi xi xi xi];
        yi=[-7 -7 -7 -7 -7 -7 -7 -7];y=[yi yi+2 yi+4 yi+6 yi+8 yi+10 yi+12 yi+14];
        qamConstellation = x+y*1j;
        temp = ceil(rand(1,Nsymbol)*64);
        for k = 1:Nsymbol,
            if temp(k) == 0,temp(k) = 1;end
            data(k) = qamConstellation(temp(k));
        end
    end
    
    X = fft(data);
    Y = zeros(Nsubcarrier,1);    
    if strcmp(SubcarrierMapping,'IFDMA')==1
        Y(1:Qi:Nsubcarrier) = X;
    elseif strcmp(SubcarrierMapping,'LFDMA')==1
        Y(1:Nsymbol) = X;
    elseif strcmp(SubcarrierMapping,'DFDMA')==1
        Y(1:Qd:Qd*Nsymbol) = X;
    end
    
    y = ifft(Y);
    if strcmp(PulseShapingFilter,'none') == 1
        yResult = y;
        t = 0:Ts:(Nsubcarrier-1)*Ts;
    else
        psFilter = rcfilter(Ts,Nos,RolloffFactor,PulseShapingFilter);
        yOversampled(1:Nos:Nos*Nsubcarrier) = y;
        yResult = filter(psFilter, 1, yOversampled);
        t = 0:Ts/Nos:(Nsubcarrier-1)*Ts;
    end
scfdm=yResult/(1e5);
end
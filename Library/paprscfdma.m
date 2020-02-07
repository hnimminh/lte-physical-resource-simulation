function [N,X]=paprscfdma(Modulation,Nsubcarrier,Nsymbol,SubcarrierMapping,PulseShapingFilter,RolloffFactor)
% DEVERLOPER: NGUYEN HOANG MINH
% Referrence from  SC-FDMA Project  
% Hyung G.Myung [Qualcomm] & David J.Goodman [NYU]
% [N,X]=paprscfdma(Modulation,Nsubcarrier,Nsymbol,SubcarrierMapping,PulseShaping,FilterType,RolloffFactor)
% semilogy(X,N),'color','g','linewidth',2);hold on;grid on;

bw=round(Nsubcarrier/100);if bw<3,bw=1.4;end;
Fs = bw*1e6;Ts = 1/Fs;Nos = 4; 
Qi = Nsubcarrier/Nsymbol;Qd = Qi-1; 
MonteCarloSim = 1e4;

papr = zeros(1,MonteCarloSim);

for n = 1:MonteCarloSim,
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
    elseif strcmp(SubcarrierMapping,'DFDMA')==1
        Y(1:Qd:Qd*Nsymbol) = X;
    elseif strcmp(SubcarrierMapping,'LFDMA')==1
        Y(1:Nsymbol) = X;
    end
    
    y = ifft(Y);
    if strcmp(PulseShapingFilter,'none') == 1
        yResult = y;
    else
        psFilter = rcfilter(Ts,Nos,RolloffFactor,PulseShapingFilter);
        yOversampled(1:Nos:Nos*Nsubcarrier) = y;
        yResult = filter(psFilter, 1, yOversampled);
    end
    
    papr(n) = 10*log10(max(abs(yResult).^2) / mean(abs(yResult).^2));
end
[N,X] = hist(papr,100);N=1-cumsum(N)/max(cumsum(N));
end
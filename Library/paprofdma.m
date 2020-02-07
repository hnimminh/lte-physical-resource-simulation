function [N,X]=paprofdma(Modulation,Nsubcarrier,Nsymbol)
% DEVERLOPER: NGUYEN HOANG MINH
% Referrence from  SC-FDMA Project  
% Hyung G.Myung [Qualcomm] & David J.Goodman [NYU]
% [N,X]=paprofdma(Modulation,Nsubcarrier,Nsymbol)
% semilogy(X,N,'color','r','linewidth',2);hold on;grid on;

bw=round(Nsubcarrier/100);if bw<3,bw=1.4;end;
Fs = bw*1e6;Ts = 1/Fs;Nos = 4; 
Fsub = [0:(Nsubcarrier-1)]*Fs/Nsubcarrier; 
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
        
    t = 0:Ts/Nos:Nsubcarrier*Ts;y = 0;
    for k = 1:Nsymbol,y= y + data(k)*exp(2j*pi*Fsub(k)*t);end
    papr(n) = 10*log10(max(abs(y).^2) / mean(abs(y).^2));
end
[N,X] = hist(papr,100);N=1-cumsum(N)/max(cumsum(N));
end
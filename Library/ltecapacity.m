function [SNRdB,DRM]=ltecapacity(Bandwidth,Modulation,CyclicPrefix,Ntx,Nrx)
% DEVERLOPER: NGUYEN HOANG MINH
% LTE DATA RATE: REPRESENT DATA RATE COMBINE WITH MIMO-RAYLEIGH FADING
% BANDWIDTH SYSTEM (MHz) [1.4 3 5 10 15 20]
% MODULATION [QPSK 16QAM 64QAM]
% CYCLICPREFIX [NORMAL EXTENDED]
% Ntx TRAN ANTENA [1 2 3 4]
% Nrx RECEIVED ANTENA [1 2 3 4]
% figure(1);plot(SNRdB,DRM);xlabel('SNR[dB]'); ylabel('Mbps');grid on;

PRB=0.9*Bandwidth/0.18;if PRB<9,PRB=6;end;
if strcmp(Modulation,'QPSK')==1,Nbit=2;
elseif strcmp(Modulation,'16QAM')==1,Nbit=4;
elseif strcmp(Modulation,'64QAM')==1,Nbit=6;
end
if strcmp(CyclicPrefix,'normal')==1,CP=7;
elseif strcmp(CyclicPrefix,'extended')==1,CP=6;
end

DataRateCore=12*20*CP*PRB*Nbit/(0.01*10^6);

MonteCarloSim=1e4;
SNRdB=-10:1:20; SNRlinear=10.^(SNRdB/10);L=length(SNRdB);
Nant=min(Ntx,Nrx); I = eye(Nant);
C= zeros(1,L);
for k=1:MonteCarloSim
H = (randn(Nrx,Ntx)+1j*randn(Nrx,Ntx));
    
    if Nrx>=Ntx, HH = H'*H; 
    else HH = H*H'; 
    end
    for i=1:L
    C(i) = C(i)+log2(real(det(I+SNRlinear(i)/Ntx*HH)));
    end
%     for i=L-14:L
%     C(i) = C(L-14);    
%     end
    
end

C = C/MonteCarloSim;DRM=C*DataRateCore;

end
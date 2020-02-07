function [mbit,qpsk,Vn,mdeb,Hx,Hy,k,L]= qpsksys(bin,f,snr)
%% This Function was writen by Deverloper Nguyen Hoang Minh
% Nguyen Hoang Minh DHDT3B, 07712001
% mbit:  matran bien doi cua chuoi nhi phan dua vao dieu che (bin)
% qam:   dang song QPSK
% Vn:    song QPSK cong nhieu AWGN 10%
% mdeb:  Choi nhi phan co duoc sau khi thuc hien giai dieu che
% Hx,Hy: la song dong bo ngang (I) & Doc (Q)
% k      do dai cua 1bit tin hieu; L do dai choi nhi phan
% Cam on!

% f=3;bin = [0 0 0 1 1 0 1 1];snr=14;
L=length(bin);k=100;%t=0:2*pi/99:2*pi;
bit1=ones(1,k);bit0=0*bit1;
symbol=ones(1,2*k);mbit=[];mx=[];my=[];

if 2*round(L/2)~=L
    error('DO DAI CUA CHUOI BINARY PHAI CHAN');
end
%============== Dieu che & du lieu  ======================================
for n=1:2:L
    if bin(n)==0 && bin(n+1)==0
       x=-1*symbol;y=-1*symbol; bit=[bit0 bit0];
   elseif bin(n)==0 && bin(n+1)==1
       x=-1*symbol;y=symbol; bit=[bit0 bit1];
   elseif bin(n)==1 && bin(n+1)==0
      x=symbol;y=-1*symbol; bit=[bit1 bit0];    
   elseif bin(n)==1 && bin(n+1)==1
       x=symbol;y=symbol; bit=[bit1 bit1]; 
    end
    mbit=[mbit bit];mx=[mx x];my=[my y];
end

v=0:2*pi/k:2*pi*L-2*pi/k;msync = mx+my*j;
%%carrier =sin(f*v);
qpsk =  real(msync).*cos(f*v)+imag(msync).*sin(f*v);
%============== Kenh truyen  =============================================
Vn=awgn(qpsk,snr,'measured');
Vnx=Vn.*cos(f*v);Vny=Vn.*sin(f*v);
[b,a]=butter(2,0.04);
%============== Giai dieu che ============================================
Hx=filter(b,a,Vnx);Hy=filter(b,a,Vny);M=length(Hx);mdeb=[];
for m=k:2*k:M
    if Hx(m)<0 && Hy(m)<0
        deb=[bit0 bit0];
    elseif Hx(m)<0 && Hy(m)>0
        deb=[bit0 bit1];
    elseif 0<Hx(m) && Hy(m) <0
        deb=[bit1 bit0];
    elseif 0<Hx(m) && Hy(m)>0
        deb=[bit1 bit1];  
end
mdeb=[mdeb deb];
end
%============== Do thi minh hoa dang song ================================
% figure(1);
% subplot(4,1,1);plot(mbit,'r','linewidth',2);axis([0  k*L -0.5 1.5]);legend('Data in');grid on;
% subplot(4,1,2);plot(qpsk,'m','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('QAM mod ');grid on;
% subplot(4,1,3);plot(Vn,'g','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('QAM mod & AWGN');grid on;
% subplot(4,1,4);plot(mdeb,'k','linewidth',1.5);axis([0  k*L -0.5 1.5]);legend('QAM demod');grid on;
% 
% figure(2)
% subplot(2,1,1);plot(Hx,'g','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('Horizontal Synchronous Xcos Wave');grid on;
% subplot(2,1,2);plot(Hy,'m','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('Vertical Synchronus Ycos Wave');grid on;  

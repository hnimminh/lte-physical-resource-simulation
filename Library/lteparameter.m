function [ubw,prb,sc,sps,fs,fft,Lcp]=lteparameter(bw,cp)
%% DEVERLOPER: NGUYEN HOANG MINH, LTE PROJECT. 12/05/11
% tinh thong so cho LTE
%prb    Physics Resource Block
%sc     SubCarrier
%sps    Symbol per Slot
%ubw    Useful BandWidth
%fs     Sample frequency
%fft    fft
%
%bw     Bandwidth    Notuser   1-1.4MHZ    2-3MHz     3-5MHz      4-10MHz     5-15MHz     6-20MHz
%cp     Cyclic prefix[Tien to vong]     1-Normal  2-Extended
%%
switch bw
    case 1.4
        ubw = 1.08;
        prb = 6;
        sc=12*prb;
        fs=1.92;
        fft=128;
    case 3
        ubw = 0.9*bw;
        prb = 5*bw;
        sc=12*prb;
        fs=3.84;
        fft=256;
    otherwise
        ubw = 0.9*bw;
        prb = 5*bw;
        sc=12*prb;
        fs=7.68*bw/5;
        fft=512*bw/5;
end

%%
switch cp
    case 1
        sps=7;
        Lcp=[5.2 4.7];
    case 2
        sps=6;
        Lcp=[16.7 0];
end

end
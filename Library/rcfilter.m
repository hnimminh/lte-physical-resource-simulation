function r=rcfilter(Ts, Nos, alpha,type)
% RCFILTER  Rised cosin filter with input parameters.
% r=rcfilter(Ts, Nos, alpha,'type')
% Ts    System sampling rate
% Nos   Over sampling factor
% Alpha Roll of Factor
% Type:     rc - rised cosin
%           rrc - root rised cosin

% Author(s): Saumil S. Shah & Atit R. Patel & H. Myng
% New Jersey Institute Of Technology,Newark,Newark, USA 07102
% Copyright 1988-2008 The MathWorks, Inc.
% $Revision: 1.20.4.3 $  $Date: 2007/12/14 15:06:42 $

if strcmp(type,'rc')==1
    r = rcPulse(Ts, Nos, alpha);
elseif strcmp(type,'rrc')==1
    r = rrcPulse(Ts, Nos, alpha);
end
end

function r = rcPulse(Ts, Nos, alpha)
t1 = -8*Ts:Ts/Nos:-Ts/Nos;
t2 = Ts/Nos:Ts/Nos:8*Ts ;
r1 = (sin(pi*t1/Ts)./(pi*t1)).*(cos(pi*alpha*t1/Ts)./(1-(4*alpha*t1/(2*Ts)).^2));
r2 = (sin(pi*t2/Ts)./(pi*t2)).*(cos(pi*alpha*t2/Ts)./(1-(4*alpha*t2/(2*Ts)).^2));
r = [r1 1/Ts r2];
end
function r = rrcPulse(Ts, Nos, alpha)
t1 = -6*Ts:Ts/Nos:-Ts/Nos;
t2 = Ts/Nos:Ts/Nos:6*Ts;
r1 = (4*alpha/(pi*sqrt(Ts)))*(cos((1+alpha)*pi*t1/Ts)+(Ts./(4*alpha*t1)).*sin((1-alpha)*pi*t1/Ts))./(1-(4*alpha*t1/Ts).^2);
r2 = (4*alpha/(pi*sqrt(Ts)))*(cos((1+alpha)*pi*t2/Ts)+(Ts./(4*alpha*t2)).*sin((1-alpha)*pi*t2/Ts))./(1-(4*alpha*t2/Ts).^2);
r = [r1 (4*alpha/(pi*sqrt(Ts))+(1-alpha)/sqrt(Ts)) r2];
end
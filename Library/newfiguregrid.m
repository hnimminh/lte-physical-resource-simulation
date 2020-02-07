function newfiguregrid(mat,color,Ncolor,width)
%% DEVERLOPER: NGUYEN HOANG MINH 
% VE LUOI TOA DO CHO MATRAN MAU BIEN DOI THANH IMAGE
% gridopen(mattrix,color,Ncolor,width,name)
% MATRIX: MATRAN CAN VE VOI GIA TRI UNG VOI MAU
% COLOR: MAU CHO DUONG KE CUA LUOI
% Ncolor: SO LUONG MAU CHO COLOR MAP
% WIDTH: DO RONG CHO DUON G KE CUA LUOI

%mat=turnmatrix(mat);
mapcolor=minhcolor(Ncolor);

%% THONG SO KHOI TAO
i= size(mat,1);ydata=[1 i];
j=size(mat,2);xdata=[1 j];

%% Lap Toa Do X-Y , Xac Lap so Hang Ngang & Cot Doc
ytop = ydata(1) - .5;
ybottom = ydata(2) + .5;
y = linspace(ytop, ybottom, i+1);

xleft = xdata(1) - .5;
xright = xdata(2) + .5;
x = linspace(xleft, xright, j+1);

xv = zeros(1, 2*length(x));
xv(1:2:end) = x;
xv(2:2:end) = x;
yv = repmat([y(1) ; y(end)], 1, length(x));
yv(:,2:2:end) = turnmatrix(yv(:,2:2:end));
xv = xv(:);
yv = yv(:);

yh = zeros(1, 2*length(y));
yh(1:2:end) = y;
yh(2:2:end) = y;
xh = repmat([x(1) ; x(end)], 1, length(y));
xh(:,2:2:end) = turnmatrix(xh(:,2:2:end));
xh = xh(:);
yh = yh(:);

%%  VE LUOI TOA DO

RGB=ind2rgb(mat,mapcolor);

hFig =figure(7);set(hFig,'Name','LTE Resource Grid. Developer: Nguyen Hoang Minh');
hIm = image(RGB);hold on;axis image;axis on;%axis xy;
line(xh, yh,'Color', color, 'LineWidth', width);line(xv,yv,'Color', color, 'LineWidth', width);

hSP = imscrollpanel(hFig,hIm);
imoverview(hIm);api = iptgetapi(hSP);api.setMagnificationAndCenter(9,306,800);set(hFig,'Position',[0 40 1400 650]);
end
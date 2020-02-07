function opengrid(matrix,color,Ncolor,width,name)
%% DEVERLOPER: NGUYEN HOANG MINH 
% VE LUOI TOA DO CHO MATRAN MAU
% gridopen(mattrix,color,Ncolor,width,name)
% MATRIX: MATRAN CAN VE VOI GIA TRI UNG VOI MAU
% COLOR: MAU CHO DUONG KE CUA LUOI
% Ncolor: SO LUONG MAU CHO COLOR MAP
% WIDTH: DO RONG CHO DUON G KE CUA LUOI
% NAME: TEN CUA DO THI

mat=turnmatrix(matrix);
colormap(minhcolor(Ncolor));

%% XAC LAP MA TRAN VE HANG & COT
i= size(mat,1);j=size(mat,2);

ytop = .5;ybottom = i + .5;
y = linspace(ytop, ybottom, i+1);

xleft = .5;xright = j + .5;
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

    image(mat);hold on;axis image;axis xy;axis on;
    title(name);xlabel('Symbol [Times]');ylabel('Subcarrier [Frequency]');
    line(xh, yh,'Color', color, 'LineWidth', width);line(xv,yv,'Color', color, 'LineWidth', width);

end
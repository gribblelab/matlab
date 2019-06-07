function D = datathief(fname)
% D = datathief(fname)
% 
% datathief loads in a bitmap image (e.g. a .jpg or .gif) 
% and lets you click on known points on the horizontal (x)
% and vertical (y) axes to define a coordinate
% system, and then lets you click on individual data points,
% and returns the (x,y) coordinates of each point in a matrix D
% 
% the assumption is of course that the x,y grid is not distorted
% for example by shear or perspective
%
% PS don't steal data

a = imread(fname);
figure
hold on
image(a);
axis ij
colormap(gray)
grid on

title('CLICK ON A (LOW) KNOWN POINT ON X-AXIS')
drawnow
x1 = ginput(1);
title('ENTER VALUE OF X-AXIS POINT YOU CLICKED ON')
drawnow
x1val = input('Enter Value: ');
title('NOW CLICK ON ANOTHER (HIGH) KNOWN POINT ON X-AXIS')
drawnow
x2 = ginput(1);
title('AGAIN, ENTER THE VALUE OF THE X-AXIS POINT YOU CLICKED ON')
x2val = input('Enter Value: ');

title('NOW CLICK ON A (LOW) KNOWN POINT ON THE Y-AXIS')
drawnow
y1 = ginput(1);
title('ENTER VALUE OF Y-AXIS POINT YOU CLICKED ON')
drawnow
y1val = input('Enter Value: ');
title('NOW CLICK ON ANOTHER (HIGH) KNOWN POINT ON Y-AXIS')
drawnow
y2 = ginput(1);
title('AGAIN, ENTER THE VALUE OF THE Y-AXIS POINT YOU CLICKED ON')
y2val = input('Enter Value: ');

title('NOW START CLICKING ON DATA POINTS! CLICK BUTTON 3 TO QUIT')
drawnow

disp('Start Clicking! (Button 3 to quit)')

PICK=[];
b = 1;
i=1;
while b~=3
	[PICK(i,1),PICK(i,2),b] = ginput(1);
	if b ~= 3
		plot(PICK(i,1),PICK(i,2),'ro');
	end;
	drawnow
	i=i+1;
end;
PICK = PICK(1:i-2,:);
PICK(:,2)=-PICK(:,2);

Y = [y1;y2];
Y(:,2)=-Y(:,2);
X = [x1;x2];
Xvals = [x1val,x2val];
Yvals = [y1val,y2val];

% first find rotation

disp('Rotating data points...')

xvec = X(2,:)-X(1,:);
rotang = atan(xvec(2)/xvec(1));
rotmat = [cos(rotang), -sin(rotang); sin(rotang),cos(rotang)];
PICKR = PICK*rotmat;
XR = X*rotmat;
YR = Y*rotmat;

disp('Translating data points...')

xtrans = XR(1,1)-Xvals(1);
ytrans = YR(1,2)-Yvals(1);
PICKRT(:,1) = PICKR(:,1)-xtrans;
PICKRT(:,2) = PICKR(:,2)-ytrans;
XRT = [XR(:,1)-xtrans,XR(:,2)-xtrans];
YRT = [YR(:,1)-xtrans,YR(:,2)-ytrans];

disp('Stretching data points...')

xamp = (Xvals(2)-Xvals(1))/(XRT(2,1)-XRT(1,1));
yamp = (Yvals(2)-Yvals(1))/(YRT(2,2)-YRT(1,2));
XRTA = [((XRT(:,1)-Xvals(1))*xamp)+Xvals(1),((XRT(:,2)-Yvals(1))*yamp)+Yvals(1)];
YRTA = [((YRT(:,1)-Xvals(1))*xamp)+Xvals(1),((YRT(:,2)-Yvals(1))*yamp)+Yvals(1)];
PICKRTA(:,1) = ((PICKRT(:,1)-Xvals(1))*xamp)+Xvals(1);
PICKRTA(:,2) = ((PICKRT(:,2)-Yvals(1))*yamp)+Yvals(1);

D = PICKRTA;


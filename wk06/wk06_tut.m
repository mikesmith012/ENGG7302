%% Question 1
clear;

xdata = [-2,-1.64,-1.33,-0.7,0,0.45,1.2,1.64,2.32,2.9];
ydata = [0.699369,0.700462,0.695354,1.03905,1.97389,2.41143,1.91091,0.919576,-0.730975, -1.42001];

fun = @(p, xdata) p(1)*cos(p(2)*xdata) + p(2)*cos(p(1)*xdata);
pguess = [1, 0.2];

p = lsqcurvefit(fun, pguess, xdata, ydata);
yguess = p(1)*cos(p(2)*xdata) + p(2)*cos(p(1)*xdata);

figure;
plot(xdata, ydata, "o"); hold on;
plot(xdata, yguess, "-"); hold off;


%% Question 2
clear;

xdata = [1.2, 2.3, 3.0, 3.8, 4.7, 5.9];
ydata = [1.1, 2.1, 3.1, 4.0, 4.9, 5.9];

fun = @(p, xdata) p(1)*xdata + p(2);
pguess = [1, 1];

p = lsqcurvefit(fun, pguess, xdata, ydata);
yguess = p(1)*xdata + p(2);

figure;
plot(xdata, ydata, "o"); hold on;
plot(xdata, yguess, "-"); hold on;

fitobj = fit(xdata', ydata', 'poly1');
yguess = fitobj.p1*xdata + fitobj.p2;
plot(xdata, yguess', "-"); hold off;


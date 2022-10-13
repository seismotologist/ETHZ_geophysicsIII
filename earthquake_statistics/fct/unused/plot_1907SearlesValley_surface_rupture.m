function srupt = plot_1907SearlesValley_surface_rupture

lnWidth=3;

f2 = shaperead('dat/Fault2-line.shp');
f3 = shaperead('dat/Fault_3-line.shp');
f4 = shaperead('dat/Fault_4-line.shp');
f5 = shaperead('dat/Fault_5_low_confidence-line.shp');
fx = shaperead('dat/Fault_trace-line.shp');

% plot(f2.X,f2.Y,'-r','lineWidth',lnWidth)
% plot(f3.X,f3.Y,'-r','lineWidth',lnWidth)
% plot(f4.X,f4.Y,'-r','lineWidth',lnWidth)
% plot(f5.X,f5.Y,'-r','lineWidth',lnWidth)
% plot(fx.X,fx.Y,'-r','lineWidth',lnWidth)

srupt.x = [f2.X,f3.X,f4.X,f5.X,fx.X]'; 
srupt.y = [f2.Y,f3.Y,f4.Y,f5.Y,fx.Y]'; 
plot(srupt.x,srupt.y,'-k','lineWidth',lnWidth+3)
plot(srupt.x,srupt.y,'-w','lineWidth',lnWidth+2)
plot(srupt.x,srupt.y,'-r','lineWidth',lnWidth)



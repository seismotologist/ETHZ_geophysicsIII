plot_rates_and_cumnum

neq = zeros(nt,1); 
M0  = zeros(nt,1);
for it = 1:nt
    print_iteration_numbers(it,nt,'hundreds')
    ts    = T(it);
    te    = T(it+1);
    useme = ctlg.t0>ts & ctlg.t0<=te;
    if sum(useme)>0
        neq(it) = sum(useme);
        M0(it)  = sum(magnitude2moment(ctlg.magnitude(useme)));
    end
end


figure(1005); clf; 
xtxrot = 45;

subplot(2,2,1); hold on; box on; grid on;
plot(Tplot,neq,'ok')
xlabel('Date')
ylabel(sprintf('No. of events per %s increment',char(dt)))
title(tstring)
set(gca,'XTickLabelRotation',xtxrot)

subplot(2,2,2); hold on; box on; grid on;
plot(Tplot,M0,'ok')
xlabel('Date')
ylabel(sprintf('Cumulative M0 per %s increment',char(dt)))
set(gca,'yscale','log','XTickLabelRotation',xtxrot)

subplot(2,2,3); hold on; box on; grid on;
plot(Tplot,cumsum(neq),'-k')
xlabel('Date')
ylabel(sprintf('Cumulative no. of events',char(dt)))
set(gca,'yscale','log','XTickLabelRotation',xtxrot)

subplot(2,2,4); hold on; box on; grid on;
plot(Tplot,cumsum(M0),'-k')
xlabel('Date')
ylabel(sprintf('Cumulative M0 [Nm/s]',char(dt)))
set(gca,'yscale','log','XTickLabelRotation',xtxrot)

set(findall(gcf,'-property','FontSize'),'FontSize',12)
set(gcf,'PaperPositionMode','auto')
%print('-dpng',sprintf('%s/srates',fbasename))

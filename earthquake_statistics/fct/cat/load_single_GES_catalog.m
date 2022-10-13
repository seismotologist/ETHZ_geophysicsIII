function catGES = load_single_GES_catalog;

catFullName       = '~/data/project/bedretto/seismicity2105/ges/202105/ST1MonitoringInt 6 Stim.csv';
catGES            = read_eqcat_Bedretto(catFullName,'ges_2105');
catGES.str.title  = catGES.params.rawfile;
catGES.str.figdir = '~/programs/seismo/fig/i39/bedretto/seismicity2105/seiscat/';
% %clf; stem(catGES.t0(catGES.Mw>-10),catGES.Mw(catGES.Mw>-10))

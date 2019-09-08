%Carpeta que contiene todas las fotos de entrenamiento
CarpetaTrain='dataset/Training sets/T-05/';
[DatosEntradaPaper,EtiquetasPaper]=Lectura(CarpetaTrain);
save('Train/DatosEntradaPaper.mat','DatosEntradaPaper');
save('Train/EtiquetasPaper.mat','EtiquetasPaper');
%se obtienen tasa de aprendizaje y momentum, si se entrena con trainscg no
%es necesario incluir u y a.
[u,a]=bestRN(DatosEntradaPaper,EtiquetasPaper);

h = @(x) FuncionFitness(x,DatosEntradaPaper, EtiquetasPaper,u,a);

%opciones del genetico
ga_opts = gaoptimset('MutationFcn', {@mutationuniform, 0.05},'TolFun', 1e-8...
                     ,'SelectionFcn',{@selectiontournament}...
                     ,'display','iter','PopulationSize',30,'Generations',100,...
                     'PopulationType','bitstring','UseParallel', true,...
                     'PlotInterval',1,'PlotFcn',{@gaplotbestf,@gaplotbestindiv,...
                     @gaplotexpectation,@gaplotrange});

[x_ga_opt, err_ga] = ga(h, 22, ga_opts);
%x_ga_opt_Paper corresponde a las mejores caracteriticas encontradas por el
%algoritmo genetico y err_ga_Paper el valor del menor del fitness
save('Resultados/x_ga_opt_Paper.mat','x_ga_opt');
save('Resultados/err_ga_Paper.mat','err_ga');
net=TrainRN(x_ga_opt,DatosEntradaPaper,EtiquetasPaper,u,a);
save('Resultados/netPaper.mat','net');


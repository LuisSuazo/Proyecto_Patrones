% x corresponde al vector de bits que entrega el algoritmo genetico
function Result = FuncionFitness(x,inputs, targets,u,a)
    tam=size(x);
    % se obtiene los 3 primeros bits para luego transformarlos a decimal
    auxBinary=x(1:3);
    firstLayer =bi2de(auxBinary());
    % se obtiene del bit 4 al 6 para luego transformarlos a decimal
    auxBinary=x(4:6);
    secondLayer=bi2de(auxBinary());
    firstLayer=5+5*firstLayer;
    secondLayer=5*secondLayer;
    cont=1;
    Datos=[];
    for k=7:tam(2)
        %Se van eliminando las columnas cuyas caracteristicas no fueron
        %seleccionadas
        if(x(k)==1)
            Datos=horzcat(Datos,inputs(:,cont)) ;
        end
        cont=cont+1;
    end
    inputs = Datos';
    targets = targets';
    %{trainlm,trainbr,trainscg,traincgf,traingdm}
    trainFcn = 'trainscg'; 
    if(secondLayer>0)
        net = patternnet([firstLayer,secondLayer],trainFcn);
        %transferFcn = {tansig,purelin,compet}
        net.layers{1}.transferFcn = 'tansig';
        net.layers{2}.transferFcn = 'tansig';
        net.layers{3}.transferFcn = 'purelin';
    else
        net = patternnet(firstLayer,trainFcn);
        net.layers{1}.transferFcn = 'tansig';
        net.layers{2}.transferFcn = 'purelin';
    end;
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    net.output.processFcns = {'removeconstantrows','mapminmax'};
    net.divideFcn = 'dividerand';  
    net.divideMode = 'sample';  
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    net.trainParam.lr=u;
    net.trainParam.mc=a;
    %{mse,crossentropy}
    net.performFcn = 'mse';  
    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
        'plotconfusion', 'plotroc'};
    Result=0;
     
    for i=1:10
       % Train the Network
        [net,tr] = train(net,inputs,targets);
        % Test the Network
        y = net(inputs);
        [c,cm,ind,per] = confusion(targets,y);
        TP=cm(1);
        FP=cm(2);
        FN=cm(3);
        TN=cm(4);
        Result=((FN+FP)/(TP+FN+TN+FP))+Result;
    end
    Result=Result/10;
end
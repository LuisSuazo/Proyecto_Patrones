function TestRN(net,x,Test,EtiquetasTrain)
 tam=size(x);
  cont=1; 
 Datos=[];
    for k=7:tam(2)
        if(x(k)==1)
            Datos=horzcat(Datos,Test(:,cont)) ;
        end
        cont=cont+1;
    end
    %display(Datos);
    inputs = Datos';
           targets = EtiquetasTrain';
        performance=0;
        FSMC=0;
        Sensitivity=0;
        Specificity=0;
        Accuracy=0;
        CCR=0;
        for i=1:10
            display('----');
            % Train the Network
            %[net,tr] = train(net,inputs,targets);
            % Test the Network
            %y = net(inputs);
            y = sim(net,inputs);
            %Yc = ind2vec(y)
            %display(y);
            [c,cm,ind,per] = confusion(targets,y);
            TP=cm(1)
            FP=cm(2)
            FN=cm(3)
            TN=cm(4)
            
            e = gsubtract(targets,y);
            performance = (perform(net,targets,y))+performance;
            tind = vec2ind(targets);
            yind = vec2ind(y);
            percentErrors = sum(tind ~= yind)/numel(tind);

            % Recalculate Training, Validation and Test Performance
            %trainTargets = targets .* tr.trainMask{1};
            %valTargets = targets .* tr.valMask{1};
            %testTargets = targets .* tr.testMask{1};
            %trainPerformance = perform(net,trainTargets,y);
            %valPerformance = perform(net,valTargets,y);
            %testPerformance = perform(net,testTargets,y);
            FSMC=((FN+FP)/(TP+FN+TN+FP))+FSMC;
            Sensitivity=((TP)/(TP+FN))+Sensitivity;
            Specificity =((TN)/(TN+FP))+Specificity;
            Accuracy=((TP)/(TP+FP))+Accuracy;
            CCR=((TP+TN)/(TP+FP+TN+FN))+CCR;
            % View the Network
            %view(net)

            % Plots
            % Uncomment these lines to enable various plots.
            %figure, plotperform(tr)
            %figure, plottrainstate(tr)
            %figure, ploterrhist(e)
            %figure, plotconfusion(t,y)
            %figure, plotroc(t,y)
        end
            performance=performance/10
            FSMC=FSMC/10
            Specificity=Specificity/10
            Sensitivity=Sensitivity/10
            Accuracy=Accuracy/10
            CCR=CCR/10
           
    end

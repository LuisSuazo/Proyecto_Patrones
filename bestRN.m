function [Bu,Ba]=bestRN(Datos,targets)
     inputs = Datos';
           targets = targets';
           %Yc = ind2vec(targets)
           Bperformance=0;
    BFSMC=999;
    BSensitivity=999;
    BSpecificity=999;
    BAccuracy=999;
    BCCR=999;
    Bu=0;
    Ba=0;
    for a = [0 0.1 0.5 0.9]
        for u = [0 0.1 0.01 0.001]
            display('**************');
            net.trainParam.lr=u;
            net.trainParam.mc=a;
               % Choose a Training Function
               %{trainlm,trainbr,trainscg,traincgf,traingdm}
               trainFcn = 'trainscg'; 
                %transferFcn = {tansig,purelin,compet}
               net = patternnet(5,trainFcn);
            net.layers{1}.transferFcn = 'tansig';
            net.layers{2}.transferFcn = 'purelin';
           net.input.processFcns = {'removeconstantrows','mapminmax'};
        net.output.processFcns = {'removeconstantrows','mapminmax'};

        % Setup Division of Data for Training, Validation, Testing
        % For a list of all data division functions type: help nndivide
        net.divideFcn = 'dividerand';  
        net.divideMode = 'sample';  
        net.divideParam.trainRatio = 70/100;
        net.divideParam.valRatio = 15/100;
        net.divideParam.testRatio = 15/100;

        % Choose a Performance Function
        % For a list of all performance functions type: help nnperformance
        %{mse,crossentropy}
        net.performFcn = 'mse';  

        % Choose Plot Functions
        % For a list of all plot functions type: help nnplot
        net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
            'plotconfusion', 'plotroc'};
        performance=0;
        FSMC=0;
        Sensitivity=0;
        Specificity=0;
        Accuracy=0;
        CCR=0;
       
        for i=1:10
             % Train the Network
            [net,tr] = train(net,inputs,targets);
            % Test the Network
            y = net(inputs);
            %Yc = ind2vec(y)
            %display(y);
            [c,cm,ind,per] = confusion(targets,y);
            TP=cm(1);
            FP=cm(2);
            FN=cm(3);
            TN=cm(4);
            %Performance=plotperform(tr);
            %Save=strcat('Resultados/Train/T-01/PER/Performance_','a_',num2str(a),'_','u_',num2str(u),'_',num2str(i),'.png');
            %saveas(Performance,Save,'png');
            e = gsubtract(targets,y);
            performance = (perform(net,targets,y))+performance;
            Rperformance=(perform(net,targets,y));
            tind = vec2ind(targets);
            yind = vec2ind(y);
            percentErrors = sum(tind ~= yind)/numel(tind);
           
            trainTargets = targets .* tr.trainMask{1};
            valTargets = targets .* tr.valMask{1};
            testTargets = targets .* tr.testMask{1};
            trainPerformance = perform(net,trainTargets,y);
            valPerformance = perform(net,valTargets,y);
            testPerformance = perform(net,testTargets,y);
          
           
            %fprintf(fid,'Epoch: %s \n',auxEpoch);
           
            % Recalculate Training, Validation and Test Performance
           
            HitTrain=1-c;
            ValuesTrain=strcat('TP: ',num2str(TP),' FP: ',num2str(FP),' FN: ',num2str(FN),' TN: ',num2str(TN));
            FSMC=((FN+FP)/(TP+FN+TN+FP))+FSMC;
            Sensitivity=((TP)/(TP+FN))+Sensitivity;
            Specificity =((TN)/(TN+FP))+Specificity;
            Accuracy=((TP)/(TP+FP))+Accuracy;
            CCR=((TP+TN)/(TP+FP+TN+FN))+CCR;
            RFSMC=((FN+FP)/(TP+FN+TN+FP));
            RSensitivity=((TP)/(TP+FN));
            RSpecificity =((TN)/(TN+FP));
            RAccuracy=((TP)/(TP+FP));
            RCCR=((TP+TN)/(TP+FP+TN+FN))+CCR;
            Save=strcat('Resultados/Train/T-05/VAL/Train_','a_',num2str(a),'_','u_',num2str(u),'_',num2str(i),'.txt');
            fid=fopen(Save,'w');
            fprintf(fid,'HIT Rate: %f \n',HitTrain);
            fprintf(fid,'%s \n',ValuesTrain);
            %fprintf(fid,'Acc Train: %s \n',RAccuracy);
            %fprintf(fid,'Performance Train: %s \n',Rperformance);
            %fprintf(fid,'FSMC Train: %s \n',RFSMC);
            %fprintf(fid,'Sensitivity Train: %s \n',RSensitivity);
            %fprintf(fid,'Specificity Train: %s \n',RSpecificity);
            %fprintf(fid,'CCR Train: %s \n',RCCR);
            fclose(fid);
            %MatrixConfusionTrain=plotconfusion(targets,y);
            %Save=strcat('Resultados/Train/T-01/MC/Train_','a_',num2str(a),'_','u_',num2str(u),'_',num2str(i),'.png');
            %saveas(MatrixConfusionTrain,Save,'png');
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
            performance=performance/10;
            FSMC=FSMC/10;
            Specificity=Specificity/10;
            Sensitivity=Sensitivity/10;
            Accuracy=Accuracy/10;
            CCR=CCR/10;
            if FSMC < BFSMC
                Bperformance=performance
                BFSMC=FSMC
                BSensitivity=Sensitivity
                BSpecificity=Specificity
                BAccuracy=Accuracy
                BCCR=CCR
                Bu=u
                Ba=a
            end
       end
    end
    Save=strcat('Resultados/Train/T-05/BP/Train_','a_',num2str(Ba),'_','u_',num2str(Bu),'.txt');
            fid=fopen(Save,'w');
            fprintf(fid,'Acc Train: %s \n',BAccuracy);
            fprintf(fid,'Performance Train: %s \n',Bperformance);
            fprintf(fid,'FSMC Train: %s \n',BFSMC);
            fprintf(fid,'Sensitivity Train: %s \n',BSensitivity);
            fprintf(fid,'Specificity Train: %s \n',BSpecificity);
            fprintf(fid,'CCR Train: %s \n',BCCR);
            fclose(fid);
 end
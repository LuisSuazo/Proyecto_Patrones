function MejorTrain()
    DatosEntradaPaper = importdata('Train/DatosEntradaPaperT-01.mat');
    EtiquetasPaper = importdata('Train/EtiquetasPaperT-01.mat');
    [uT1,aT1]=bestRN(DatosEntradaPaper,EtiquetasPaper);
    
end
CarpetaTest='dataset/Test sets/E-05/';
[MatrizImput,Etiquetas]=Lectura(CarpetaTest);
save('Test/Test_E-05.mat','MatrizImput');
save('Test/Car_E-05.mat','Etiquetas');
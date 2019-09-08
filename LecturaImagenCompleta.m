function [MatrizImput]=LecturaImagenCompleta(Nombre)
   
    MatrizImput=[];
    FRedVector=[];
    FGreenVector=[];
    FBlueVector=[];
    FRGVector=[];
    FRBVector=[];
    FGRVector=[];
    FGBVector=[];
    FBRVector=[];
    FBGVector=[];
    FGRBVector=[];
    FHVector=[];
    FSVector=[];
    FVVector=[];
    FLVector=[];
    FAVector=[];
    FBVector=[];
    Etiquetas=[];
    %for k = 1:length(myFiles)
            %FileName = myFiles(k).name;
            %NombreImagen=strcat(Carpeta,FileName);
            Imagen=imread(Nombre);
            display(size(Imagen));
            hsv = rgb2hsv(Imagen);
            lab = rgb2lab(Imagen);
            %display('*******');
            lab=double(lab)/255;
            Imagen=im2double(Imagen);
            %display(Imagen);
            redChannel = Imagen(:, :, 1);
            redVector= reshape(redChannel, 1, []);
            %redVector=double(redVector)/255;
            greenChannel = Imagen(:, :, 2);
            greenVector= reshape(greenChannel, 1, []);
            %greenVector=double(greenVector)/255;
            blueChannel = Imagen(:, :, 3);
            blueVector= reshape(blueChannel, 1, []);
            %blueVector=double(blueVector)/255;
            RB=redChannel-blueChannel;
            RBVector=reshape(RB, 1, []);
            %RBVector=double(RBVector)/255;
            RG=redChannel-greenChannel;
            RGVector=reshape(RG, 1, []);
            %RGVector=double(RGVector)/255;
            GR=greenChannel-redChannel;
            GRVector=reshape(GR, 1, []);
            %GRVector=double(GRVector)/255;
            GB=greenChannel-blueChannel;
            GBVector=reshape(GB, 1, []);
            %GBVector=double(GBVector)/255;
            BR=blueChannel-redChannel;
            BRVector=reshape(BR, 1, []);
            %BRVector=double(BRVector)/255;
            BG=blueChannel-greenChannel;
            BGVector=reshape(BG, 1, []);
            %BGVector=double(BGVector)/255;
            GRB=(2*greenChannel-redChannel-blueChannel)/255;
            GRBVector=reshape(GRB, 1, []);
            %GRBVector=double(GRBVector)/255;
            h = hsv(:, :, 1);
            HVector= reshape(h, 1, []);
            s = hsv(:, :, 2);
            SVector= reshape(s, 1, []);
            v = hsv(:, :, 3);
            VVector= reshape(v, 1, []);
            l = lab(:, :, 1);
            LVector= reshape(l, 1, []);
            a = lab(:, :, 2);
            AVector= reshape(a, 1, []);
            b = lab(:, :, 3);
            BVector= reshape(b, 1, []);
            FRedVector=horzcat(FRedVector,redVector);
            FGreenVector=horzcat(FGreenVector,greenVector);
            FBlueVector=horzcat(FBlueVector,blueVector);
            FRGVector=horzcat(FRGVector,RGVector);
            FRBVector=horzcat(FRBVector,RBVector);
            FGRVector=horzcat(FGRVector,GRVector);
            FGBVector=horzcat(FGBVector,GBVector);
            FBRVector=horzcat(FBRVector,BRVector);
            FBGVector=horzcat(FBGVector,BGVector);
            FGRBVector=horzcat(FGRBVector,GRBVector);
            FHVector=horzcat(FHVector,HVector);
            FSVector=horzcat(FSVector,SVector);
            FVVector=horzcat(FVVector,VVector);
            FLVector=horzcat(FLVector,LVector);
            FAVector=horzcat(FAVector,AVector);
            FBVector=horzcat(FBVector,BVector);
           %Etiqueta=FileName(1);
            %display(Etiqueta);
          %  if Etiqueta=='N'
                numero=0;
          %  else
                numero=1;
          %  end;
          %  for i = 1:100
                Etiquetas=vertcat(Etiquetas,numero);
          %  end

            %imshow(Imagen);
            %display('*******');
    %end
    %display(Etiquetas);

    MatrizImput=vertcat(MatrizImput,FRedVector,FGreenVector,FBlueVector,FRGVector...
                        ,FRBVector,FGRVector,FGBVector,FBRVector,FBGVector...
                        ,FGRBVector,FHVector,FSVector,FVVector,FLVector,FAVector,FBVector);
    %display(MatrizImput);
    FGreenVector=[];
    FBlueVector=[];
    FRGVector=[];
    FRBVector=[];
    FGRVector=[];
    FGBVector=[];
    FBRVector=[];
    FBGVector=[];
    FGRBVector=[];
    FHVector=[];
    FSVector=[];
    FVVector=[];
    FLVector=[];
    FAVector=[];
    FBVector=[];           
    %MatrizImput=MatrizImput';
    %Etiquetas=Etiquetas';
    %display(Etiquetas);
    MatrizImput=MatrizImput';
    %display(MatrizImput);
    display('Finalizo Lectura');
end
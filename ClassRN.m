function ClassRN(net,x,Test,NombreFoto,Salida)
    tam=size(x);
    cont=1; 
    Datos=[];
    for k=7:tam(2)
        if(x(k)==1)
            Datos=horzcat(Datos,Test(:,cont)) ;
        end
        cont=cont+1;
    end
    Matriz=[];
    auxVector=[];
    inputs = Datos';
    display('----');
    y = sim(net,inputs);
    y=y';
    display(size(y));
    cont=1;
    for i=1 : size(y)
        m = abs(y(i));
       	%display(m);
        if m<0.5
            auxVector=horzcat(auxVector,0);
        else
            auxVector=horzcat(auxVector,1);
        end
        if cont==2592
            % display(size(auxVector));
            Matriz=vertcat(Matriz,auxVector);
            auxVector=[];
            cont=1;
        else
            cont=cont+1;
        end
    
     end
     Matriz=Matriz';
     Imagen=imread(NombreFoto);
     %imshow(Imagen);
     for i=1:2592
        for j=1:3888
            if Matriz(i,j)==0
                Imagen(i,j,1)=0;
                Imagen(i,j,2)=0;
                Imagen(i,j,3)=0;
            end
        end
     end
     imwrite(Imagen,Salida)
end

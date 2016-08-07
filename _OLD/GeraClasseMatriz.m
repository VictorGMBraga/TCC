amostras = zeros(10,8);
for o = 0:9
    pasta = sprintf('%d/11x11/*.png', o);
    imageFiles = dir(pasta);
    for j = 1: length(imageFiles)
        fileName = sprintf('%d/11x11/%s',o,imageFiles(j).name);
        numero = imread(fileName);
        posicao = str2double(imageFiles(j).name(length(imageFiles(j).name)-4));
        if o ~= 0
            correcaoVetor = o;
        else
            correcaoVetor = 10;
        end
        amostras(correcaoVetor,posicao) = amostras(correcaoVetor,posicao) + 1; 
            
        for l = 1:size(numero, 1)
            for m = 1:size(numero, 2)
               matrizes(correcaoVetor,posicao,amostras(correcaoVetor,posicao),l,m,1) = numero(l,m,1);
            end 
        end
        for l = 1:size(numero, 1)
            for m = 1:size(numero, 2)
               matrizes(correcaoVetor,posicao,amostras(correcaoVetor,posicao),l,m,2) = numero(l,m,2);
            end 
        end
        
        for l = 1:size(numero, 1)
            for m = 1:size(numero, 2)
               matrizes(correcaoVetor,posicao,amostras(correcaoVetor,posicao),l,m,3) = numero(l,m,3);
            end 
        end
    end 
end
disp(matrizes);
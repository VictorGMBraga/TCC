for o = 0:9
    pasta = sprintf('C:/Users/Rafael/Documents/MATLAB/ProcessamentoPlacar/Recortes/%d/*.png', o);
    imageFiles = dir(pasta);
    for j = 1: length(imageFiles)
        fileName = sprintf('C:/Users/Rafael/Documents/MATLAB/ProcessamentoPlacar/Recortes/%d/%s',o,imageFiles(j).name);
        numero = imread(fileName);
        posicao = str2double(imageFiles(j).name(length(imageFiles(j).name)-4));
        nome = sprintf('C:/Users/Rafael/Documents/MATLAB/ProcessamentoPlacar/Recortes/%d/Posicao%d.txt',o,posicao);
        fp = fopen(nome, 'at');
        
        fprintf(fp,'Vermelho\n');
        for l = 1:size(numero, 1)
            for m = 1:size(numero, 2)
               fprintf(fp,'%d \t', numero(l,m,1));
            end 
            fprintf(fp,'\n');
        end
        
        fprintf(fp,'\n\n\n');
        
        fprintf(fp,'Verde\n');
        for l = 1:size(numero, 1)
            for m = 1:size(numero, 2)
               fprintf(fp,'%d \t', numero(l,m,2));
            end 
            fprintf(fp,'\n');
        end 
        fprintf(fp,'\n\n\n');
        fprintf(fp,'Azul\n');
        for l = 1:size(numero, 1)
            for m = 1:size(numero, 2)
               fprintf(fp,'%d \t', numero(l,m,3));
            end 
            fprintf(fp,'\n');
        end         
        fprintf(fp,'\n\n\n==========================================\n\n\n');
        
        fclose(fp);    
    end 
end
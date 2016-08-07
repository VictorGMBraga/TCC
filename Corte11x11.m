for i = 0: 9
    nome = sprintf('%d/*.png', i);
    imageFiles = dir(nome);
    for j = 1: length(imageFiles)
        fileName = sprintf('%d/%s',i,imageFiles(j).name);
        original = imread(fileName);    
        imagem11x11 = imcrop(original, [4 2 10 10]);
        nomeFinal = sprintf ('%d/11x11/%s',i,imageFiles(j).name);
        imwrite(imagem11x11,nomeFinal);
    end
end
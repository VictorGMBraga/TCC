imageFiles = dir('C:/Users/Rafael/Documents/MATLAB/ProcessamentoPlacar/*.png');

for j = 1: length(imageFiles)
    fileName = sprintf('C:/Users/Rafael/Documents/MATLAB/ProcessamentoPlacar/%s',imageFiles(j).name);
    original = imread(fileName);    
    placarImg = imcrop(original,[109 39 104 13]);
    numberImg = imcrop(placarImg,[78 0 13 13]);
    for i = 0:13:91 
        numberImg = imcrop(placarImg,[i 0 13 13]);
        brancos = numberImg(:,:,1) >= 90;
        [B,L] = bwboundaries(brancos, 'noholes');
        stats = regionprops(L, 'Area');
        qtd_numeros = sum([stats.Area] > 25);
        if qtd_numeros > 0
            nome = sprintf ('C:/Users/Rafael/Documents/MATLAB/ProcessamentoPlacar/Recortes/Img%d_Posicao_%d.png', j,i/13);
            imwrite(numberImg,nome)
        end 
    end
end
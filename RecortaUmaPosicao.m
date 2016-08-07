original = imread('2 (2).png');
placarImg = imcrop(original,[109 39 104 13]);
numberImg = imcrop(placarImg,[56 2 10 10]);
imshow(numberImg);
imwrite(numberImg,'Recortes/0/11x11/img133_posicao_4.png');

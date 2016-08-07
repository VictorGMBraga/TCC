function resultado = ReconheceNum( img, pos, matrizes )
    menor_dist = inf;
    for i = 1:10
        for j = 1:size(matrizes,3)
            
           temp = DistanciaEuclidiana(img, reshape(matrizes(i,pos,j,:,:,:),[11,11,3])); 
           
           if(temp < menor_dist)
               menor_dist = temp;
               resultado = i;
           end
        end
    end
end


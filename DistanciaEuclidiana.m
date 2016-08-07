function dist = DistanciaEuclidiana( img1, img2 )
    dist = sum(sum(sum((double(img1) - double(img2)).^2)));
end


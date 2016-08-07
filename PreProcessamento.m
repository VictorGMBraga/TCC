function frame_out = PreProcessamento( frame_in )
    frame_temp = imcrop(frame_in,[145 71 352 374]);
    frame_out = rgb2gray(frame_temp);
end


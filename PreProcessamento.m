function frame_out = preProcessamento( frame_in )
    frame_temp = imcrop(frame_in,[72 34 176 188]);
    frame_out = bwareaopen(rgb2gray(frame_temp),10);
end


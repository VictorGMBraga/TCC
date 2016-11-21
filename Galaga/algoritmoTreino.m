frameTime = 0.33;
gamma = 0.7;
exps(20) = experience;
estado = [];
prox_estado = [];
i = 1;
k = 1;
e = 0.01;
%im = imshow(zeros(47,45,3));
pause(5);

frame = screencapture(0,[2,202,640,480]);
frame_nave = imcrop(frame,[145 419 352 26]);
%imshow(frame_nave);
estado = double(vertcat(estado,reshape(rgb2gray(imcrop(imresize(frame,0.125),[18 9 45 47])),[],1)));
tic;

while(k < 4)    
    if(toc > frameTime)
        frame = screencapture(0,[2,202,640,480]);
        frame_nave = imcrop(frame,[145 419 352 26]);
        estado = double(vertcat(estado,reshape(rgb2gray(imcrop(imresize(frame,0.125),[18 9 45 47])),[],1)));
        k = k + 1;
        tic;
    end
end

k = k + 1;

while true
    frame = screencapture(0,[2,202,640,480]);
    frame_nave = imcrop(frame,[145 419 352 26]);
    se_menu = abs(double(frame(400,100,3)) - 127);
    %zdisp('LOOP');
    
    if(se_menu < 10)
        atira();
    elseif(max(max(frame_nave(:,:,1))) > 200)
        %disp('NAVE');
        placarAnt = CalculaPlacar(frame);
        if(k == 5)
            if(rand < e)
                acao = randi(6);
            else
                aux = net(estado);
                acao = find(aux ==  max(aux));
            end
            k = 1;
            soltaBotoes();
            switch(acao)
                case 1
                    atira();
                case 2
                    atira();
                    andaEsq();
                case 3
                    atira();
                    andaDir();
                case 4
                    andaEsq();
                case 5
                    andaDir();
            end
            prox_estado = [];
            tic;
        end
        
        if(toc > frameTime)
            frame = screencapture(0,[2,202,640,480]);
            frame_preproc = rgb2gray(imcrop(imresize(frame,0.125),[18 9 45 47]));
            %set(im,'CData', frame_preproc);
            %drawnow;
            prox_estado = double(vertcat(prox_estado,reshape(frame_preproc,[],1)));
            k = k + 1;
            tic;
            if(k == 5)
                recompensa = CalculaPlacar(frame) - placarAnt;
                if(i < 21)
                    exps(i).store(estado, acao, recompensa,prox_estado);
                    trainSample = exps(randi(i)).get();
                    i = i + 1;
                else
                    exps(randi(20)).store(estado, acao, recompensa,prox_estado);
                    trainSample = exps(randi(20)).get();
                end

                retornoRedeEstado = net(trainSample.estado);
                retornoRedeProxEstado = net(trainSample.prox_estado);

                retornoRedeEstado(trainSample.acao) = trainSample.recompensa + gamma * max(retornoRedeProxEstado);

                net = train(net, trainSample.estado,retornoRedeEstado);

                estado = prox_estado;
            end
        end

        if(acao <= 3)
            atira();
        end
        %disp(CalculaPlacar(frame_prox));
    end
end
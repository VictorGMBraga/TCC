vid = videoinput('winvideo', 2, 'RGB32_320x240');
set(vid,'framesperTrigger',1,'TriggerRepeat',Inf);
start(vid);
e = 1;
frame = getsnapshot(vid);
frame_recorte = imcrop(rgb2gray(frame),[72 34 176 188]);
tic;
i = 1;
gamma = 0.9;

num0 = imcrop(frame,[62 13 5 5]);
num1 = imcrop(frame,[68 13 5 5]);
num2 = imcrop(frame,[74 13 5 5]);
num3 = imcrop(frame,[80 13 5 5]);
num4 = imcrop(frame,[86 13 5 5]);
num5 = imcrop(frame,[92 13 5 5]);
num6 = imcrop(frame,[98 13 5 5]);
num7 = imcrop(frame,[104 13 5 5]);

dig(1) = menorDistancia(num0);
dig(2) = menorDistancia(num1);
dig(3) = menorDistancia(num2);
dig(4) = menorDistancia(num3);
dig(5) = menorDistancia(num4);
dig(6) = menorDistancia(num5);
dig(7) = menorDistancia(num6);
dig(8) = menorDistancia(num7);

recompensa_atual = sum(10.^(length(dig)-1:-1:0).*dig);

if(rand < e)
   acao = round(rand * 5);
end

switch acao
    case 0
        atira();
    case 1
        andaEsq();
    case 2
        andaDir();
    case 3
        atira();
        andaEsq();
    case 4
        atira();
        andaDir();
end

while islogging(vid)
    
    if(toc > 0.2)
        tic;
        frame_prox = getsnapshot(vid);
        flushdata(vid);
        frame_recorte_prox = imcrop(rgb2gray(frame_prox),[72 34 176 188]);
        soltaBotoes();
        
        %imshow(frame_recorte_prox);
        %cnn(frames);

        num0 = imcrop(frame_prox,[62 13 5 5]);
        num1 = imcrop(frame_prox,[68 13 5 5]);
        num2 = imcrop(frame_prox,[74 13 5 5]);
        num3 = imcrop(frame_prox,[80 13 5 5]);
        num4 = imcrop(frame_prox,[86 13 5 5]);
        num5 = imcrop(frame_prox,[92 13 5 5]);
        num6 = imcrop(frame_prox,[98 13 5 5]);
        num7 = imcrop(frame_prox,[104 13 5 5]);

        dig(1) = menorDistancia(num0);
        dig(2) = menorDistancia(num1);
        dig(3) = menorDistancia(num2);
        dig(4) = menorDistancia(num3);
        dig(5) = menorDistancia(num4);
        dig(6) = menorDistancia(num5);
        dig(7) = menorDistancia(num6);
        dig(8) = menorDistancia(num7);

        recompensa_prox = sum(10.^(length(dig)-1:-1:0).*dig);
        recompensa = recompensa_prox - recompensa_atual;
        recompensa_atual = recompensa_prox;
        disp(recompensa);
        
        if(i < 21)
            exps(i).store(frame_recorte,acao,recompensa/15000000,frame_recorte_prox);
            treina = exps(round((rand*(i-1))+1)).get;
            i = i+1;
        else
            exps(round((rand*19)+1)).store(frame_recorte,acao,recompensa,frame_recorte_prox);
            treina = exps(round((rand*19)+1)).get;
        end
        
        prox_estado = net(reshape(treina.prox_estado,[],1));
        max_prox_estado = max(prox_estado);
        
        if(abs(double(treina.prox_estado(165,11)) - 105) < 10)
            tt = treina.recompensa;
        else
            tt = treina.recompensa + gamma * max_prox_estado;
        end
        
        saida_rede_atual = net(reshape(treina.estado,[],1));
        saida_rede_atual(find(prox_estado == max_prox_estado)) = tt;
        
        net = train(net,reshape(treina.estado,[],1),saida_rede_atual);
        
        frame = frame_prox;
        
        if(rand < e)
           acao = round(rand * 5);
        else
           acoes = net(reshape(frame,[],1));
           acao = find(net(acoes == max(acoes))) - 1;
        end
        
        e = e - 0.00000001;
        
        switch acao
            case 0
                atira();
            case 1
                andaEsq();
            case 2
                andaDir();
            case 3
                atira();
                andaEsq();
            case 4
                atira();
                andaDir();
        end

        
    end
    
end
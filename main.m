vid = videoinput('winvideo', 2, 'RGB32_320x240');
set(vid,'framesperTrigger',1,'TriggerRepeat',Inf);
start(vid);

h = imshow(zeros(240,320));
hold on;

if(~exist('qsa','var'))
    qsa = struct('s',{},'a',{},'r',{});
end;
a = 1;
recompensa = 0;
alpha = 0.7;
gama = 1;

while islogging(vid);
    frame = getdata(vid,1);
    %frame = frame(:,:,1) >= 90;
    
    recorte = preProcessamento(frame);
    flushdata(vid);
    %imimshow(recorte);
    
    set(h,'Cdata',recorte);
    drawnow;
    
    se_menu = abs(double(recorte(165,11)) - 105);
    
    if(se_menu < 10)
        %atira();
    else
        a = 1;
        maior_r = 1;
        a_maior_r = 1;

        if(buscaPorHash(qsa, recorte, a) == 0)
            %a = 2;
            qsa(length(qsa) + 1).s = recorte;
            qsa(length(qsa)).a = a;
            qsa(length(qsa)).r = 0;
            posicao = length(qsa);
        else
            posicao = buscaPorHash(qsa, recorte, a);
            while(posicao ~= 0 & a < 5)
                if(qsa(posicao).r > maior_r)
                    disp('OI');
                    maior_r = qsa(posicao).r;
                    a_maior_r = a;
                end;
                a = a + 1;
                posicao = buscaPorHash(qsa, recorte, a);
            end;
            if(a == 5)
                a = a_maior_r;
                posicao = buscaPorHash(qsa, recorte, a);
            else
                qsa(length(qsa) + 1).s = recorte;
                qsa(length(qsa)).a = a;
                qsa(length(qsa)).r = 0;
                posicao = length(qsa);
            end;
        end;

        switch(a)
            case 1
                disp('POW');
                atira();
            case 2
                disp('ESQ');
                andaEsq();
            case 3
                disp('DIR');
                andaDir();
            case 4
                disp('PARADO');
        end;

        frame = getsnapshot(vid);
        recorte = preProcessamento(frame);

        num0 = imcrop(frame,[62 13 5 5]);
        num1 = imcrop(frame,[68 13 5 5]);
        num2 = imcrop(frame,[74 13 5 5]);
        num3 = imcrop(frame,[80 13 5 5]);
        num4 = imcrop(frame,[86 13 5 5]);
        num5 = imcrop(frame,[92 13 5 5]);
        num6 = imcrop(frame,[98 13 5 5]);
        num7 = imcrop(frame,[104 13 5 5]);

        %qtd_vidas = NumVidas(frame);
        %disp(qtd_vidas);

        dig(1) = menorDistancia(num0);
        dig(2) = menorDistancia(num1);
        dig(3) = menorDistancia(num2);
        dig(4) = menorDistancia(num3);
        dig(5) = menorDistancia(num4);
        dig(6) = menorDistancia(num5);
        dig(7) = menorDistancia(num6);
        dig(8) = menorDistancia(num7);

        recompensa = sum(10.^(length(dig)-1:-1:0).*dig) - recompensa;
        qsa(posicao).r = qsa(posicao).r + alpha * ( recompensa * gama * maior_r - qsa(posicao).r );
        %disp(qsa(posicao).r);
        %disp(sum(10.^(length(dig)-1:-1:0).*dig));
    end;    
end

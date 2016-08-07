vid = videoinput('winvideo', 2, 'RGB32_640x480');
%src = getselectedsource(vid);
vid.FramesPerTrigger = 1;

%qsa = struct('s',{},'a',{},'r',{});
a = 1;
recompensa = 0;
alpha = 0.7;
gama = 1;

while true
    frame = getsnapshot(vid);
    %frame = frame(:,:,1) >= 90;
    
    recorte = preProcessamento(frame);
    %imshow(recorte);
    
    se_menu = abs(double(recorte(329,22)) - 105);
    disp(se_menu);
    
    if(se_menu < 10)
        atira();
    else
        a = 1;
        maior_r = 0;
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
                    maior_r = qsa(posicao).r;
                    a_maior_r = a;
                end;
                a = a + 1;
                posicao = buscaPorHash(qsa, recorte, a);
            end;
            if(a == 5)
                a = a_maior_r;
            else
                qsa(length(qsa) + 1).s = recorte;
                qsa(length(qsa)).a = a;
                qsa(length(qsa)).r = 0;
                posicao = length(qsa);
            end;
        end;

        switch(a)
            case 1
                disp('PARADO');
            case 2
                disp('ESQ');
                andaEsq();
            case 3
                disp('DIR');
                andaDir();
            case 4
                disp('POW');
                atira();
        end;

        frame = getsnapshot(vid);
        recorte = preProcessamento(frame);

        num0 = imcrop(frame,[208 26 10 10]);
        num1 = imcrop(frame,[195 26 10 10]);
        num2 = imcrop(frame,[182 26 10 10]);
        num3 = imcrop(frame,[169 26 10 10]);
        num4 = imcrop(frame,[156 26 10 10]);
        num5 = imcrop(frame,[143 26 10 10]);
        num6 = imcrop(frame,[130 26 10 10]);
        num7 = imcrop(frame,[117 26 10 10]);

        %qtd_vidas = NumVidas(frame);
        %disp(qtd_vidas);

        dig(8) = menorDistancia(num0);
        dig(7) = menorDistancia(num1);
        dig(6) = menorDistancia(num2);
        dig(5) = menorDistancia(num3);
        dig(4) = menorDistancia(num4);
        dig(3) = menorDistancia(num5);
        dig(2) = menorDistancia(num6);
        dig(1) = menorDistancia(num7);

        recompensa = sum(10.^(length(dig)-1:-1:0).*dig) - recompensa;
        qsa(posicao).r = qsa(posicao).r + alpha * ( recompensa * gama * maior_r - qsa(posicao).r );
        %disp(sum(10.^(length(dig)-1:-1:0).*dig));
    end;    
end

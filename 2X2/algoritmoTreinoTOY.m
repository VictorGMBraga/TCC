jogo = Jogo;

estado = jogo.table;

gamma = 0.7;

exps(20) = experience;
i = 1;
j = 1;

logPlacar = zeros(1, 5000);

im = imshow(zeros(2,2));
cd = get(im, 'CData');

%for j = 1: 5000 
while true
    placarAnt = jogo.placar;
    if(rand < e)
        acao = randi(3);
        %e = e - 0.0001; 
    else
        aux = net(reshape(estado,[],1));
        acao = find(aux ==  max(aux)); 
    end
    jogo.MoveEnemy();
    jogo.MovePlayer(acao);
    jogo.Update();
  
    recompensa = jogo.placar - placarAnt;
    
    jogo.MoveEnemy();
    jogo.Update();
    proxEstado = jogo.table;

    
    if(i < 21)
        exps(i).store(estado, acao, recompensa,proxEstado);
        trainSample = exps(randi(i)).get();
        i = i + 1;
    else
        exps(randi(20)).store(estado, acao, recompensa,proxEstado);
        trainSample = exps(randi(20)).get();
    end
    
    retornoRedeEstado = net(reshape(trainSample.estado,[],1));
    retornoRedeProxEstado = net(reshape(trainSample.prox_estado,[],1));
    
    retornoRedeEstado(trainSample.acao) = trainSample.recompensa + gamma * max(retornoRedeProxEstado);
    
    net = train(net, reshape(trainSample.estado,[],1),reshape(retornoRedeEstado,[],1));
    
    logPlacar(j) = jogo.placar;
    
    if( mod(j, 100) == 0)
        disp(j);
        disp(jogo.placar);
    end

    set(im,'CData', jogo.table);
    drawnow;
    
    estado = proxEstado;
    j = j + 1;
end 
jogo = Jogo;
estado = [];

for i = 1:2
    estado = vertcat(estado,reshape(jogo.table,[],1));
    jogo.MoveEnemy();
    jogo.Update();
end

estado = vertcat(estado,reshape(jogo.table,[],1));
gamma = 0.7;

exps(20) = experience;
i = 1;
j = 1;

logPlacar = zeros(1, 5000);

im = imshow(zeros(4,4));
cd = get(im, 'CData');

while true
    placarAnt = jogo.placar;
    if(rand < e)
        acao = randi(3);
        %e = e - 0.0001; 
    else
        aux = net(estado);
        acao = find(aux ==  max(aux)); 
    end
    jogo.MoveEnemy();
    jogo.MovePlayer(acao);
    jogo.Update();
    set(im,'CData', jogo.table);
    drawnow;
    
    recompensa = jogo.placar - placarAnt;
 
    jogo.MoveEnemy();
    jogo.Update();
    set(im,'CData', jogo.table);
    drawnow;
    
    proxEstado = [];
    
    for k = 1:2
        proxEstado = vertcat(proxEstado,reshape(jogo.table,[],1));
        jogo.MoveEnemy();
        jogo.MovePlayer(acao);
        jogo.Update();
        set(im,'CData', jogo.table);
        drawnow;
    end;
    
    proxEstado = vertcat(proxEstado,reshape(jogo.table,[],1));
    
    if(i < 21)
        exps(i).store(estado, acao, recompensa,proxEstado);
        trainSample = exps(randi(i)).get();
        i = i + 1;
    else
        exps(randi(20)).store(estado, acao, recompensa,proxEstado);
        trainSample = exps(randi(20)).get();
    end
    
    retornoRedeEstado = net(trainSample.estado);
    retornoRedeProxEstado = net(trainSample.prox_estado);
    
    retornoRedeEstado(trainSample.acao) = trainSample.recompensa + gamma * max(retornoRedeProxEstado);
    
    net = train(net, trainSample.estado,retornoRedeEstado);
    
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
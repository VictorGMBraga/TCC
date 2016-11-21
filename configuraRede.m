net = feedforwardnet
net.trainParam.epochs = 1
net.trainFcn = 'trainscg'
net.divideFcn = ''
net.trainParam.showWindow = false
net = configure(net,A,B)
function andaDir
    import java.awt.Robot;
    robo = Robot;
    robo.keyPress(39); %Seta Direita
    robo.delay(500);
    pause(0.5);
    robo.keyRelease(39);
end
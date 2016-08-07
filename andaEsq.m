function andaEsq 
    import java.awt.Robot;
    robo = Robot;
    robo.keyPress(37); %Seta Esquerda
    robo.delay(500);
    pause(0.5);
    robo.keyRelease(37);
end
function atira
    import java.awt.Robot;
    robo = Robot;
    robo.keyPress(90); %Z
    robo.delay(500);
    pause(0.5);
    robo.keyRelease(90);
end
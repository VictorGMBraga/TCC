import java.awt.Robot;

robo = Robot;
system('%windir%\explorer.exe shell:::{3080F90E-D7AD-11D9-BD98-0000947B0257}');
pause(2);
robo.keyPress(10);%tecla Enter
robo.keyRelease(90);%tecla y
pause(2);
robo.keyPress(90);%tecla y
pause(5);
robo.keyRelease(90);%tecla y
screenSize = get(0, 'screensize');
for i = 1: screenSize(4)
    robo.keyPress(90);%tecla y
    pause(0.00001);
    robo.keyRelease(90);%tecla y
end
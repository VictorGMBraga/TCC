i = 1;
while i < 1200
    robo = java.awt.Robot;
    t = java.awt.Toolkit.getDefaultToolkit();

    %# Set the capture area as the size for the screen
    rectangle = java.awt.Rectangle(t.getScreenSize());

    %# Get the capture
    image = robo.createScreenCapture(rectangle);

    imshow(image);
    
    pause(16) %# Wait for 5 min
    i = i + 1;
end
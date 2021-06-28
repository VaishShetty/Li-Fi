clc;    %Clear Conmand Window
close all;  % Close all figure windows
clear all;  % Delete all existing varibales 

%% Main Processing

prompt='Enter text to send';
name ='Text';
a = char(inputdlg(prompt,name));    % Display a Dialog box to enter text
disp(a);    % Display input character on command window
f =(dec2bin(a,8)-'0');  % convert character into bits
c = [f];    % Array of bits
disp(c);    % Display bits on Command window
[m,n]=size(c);  % Rows and column of variable c
d = arduino('COM5', 'Uno');     % Create an Arduino object

% Transmit initial Pilot bits
for l = 1:7
    writeDigitalPin(d,'D7',1);  % Set digital pin D7 to high Voltage
    pause(1);
end

% Iterate through the array and transmit data bits
for i = 1:m 
    for j = 1:8
       b = c(i,j);      % Access the value of array c
       if b == 1
           writeDigitalPin(d, 'D7', 1);     % Set digital pin D7 to high Voltage
           pause (1);    
       else
           writeDigitalPin(d, 'D7', 0);     % Set digital pin D7 to low Voltage
          pause (1);
       end
       
    end
end
 
clear d;    % Clear Arduino object 

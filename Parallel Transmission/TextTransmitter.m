clc;    %Clear Conmand Window
close all;  % Close all figure windows
clear all;  % Delete all existing varibales 

%% Main Processing

prompt='Enter text to send';
name ='Text';
a = char(inputdlg(prompt,name));    % Display a Dialog box to enter text
disp(a);    % Display input character on command window
f =(dec2bin(a,8)-'0');  % convert character into bits
c = {f};    % Array of bits
disp(c);    % Display bits on Command window
[m,n]=size(c);  % Rows and column of variable c
d = arduino('COM5', 'Uno');     % Create an Arduino object

% Transmit initial Pilot bits
for l = 1:7
    writeDigitalPin(d,'D7',1);  % Set digital pin D7 to high Voltage
    writeDigitalPin(d,'D4',1);  % Set digital pin D4 to high Voltage    
    pause(1);
end

% Iterate through the array and transmit data bits
for i = 1:m 
    for j = 1:n/2
        % Access the value of array c
       tx1_bit = c(i,j);        % starts from the 4th bit of each row
       tx2_bit = c(i,(n/2)+j);   % starts from the 4th bit of each row
       
       if (tx1_bit == 1 && tx2_bit ==1)
           writeDigitalPin(d, 'D7', 1),   % Set digital pin D7 to high Voltage
           writeDigitalPin(d, 'D4', 1),pause (2);   % Set digital pin D4 to high Voltage
       
       elseif(tx1_bit == 1 && tx2_bit ==0)
           writeDigitalPin(d, 'D7', 1),   % Set digital pin D7 to high Voltage
           writeDigitalPin(d, 'D4', 0),pause (2);   % Set digital pin D4 to low Voltage
           
      elseif(tx1_bit == 0 && tx2_bit ==1)
           writeDigitalPin(d, 'D7', 0),   % Set digital pin D7 to low Voltage
           writeDigitalPin(d, 'D4', 1),pause (2);   % Set digital pin D4 to high Voltage
           
      elseif(tx1_bit == 0 && tx2_bit ==0)
           writeDigitalPin(d, 'D7', 0),   % Set digital pin D7 to low Voltage
           writeDigitalPin(d, 'D4', 0),pause (2);   % Set digital pin D4 to low Voltage       
       end
    end
end
 
clear d;    % Clear Arduino object 

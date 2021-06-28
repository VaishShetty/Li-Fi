clc;    %Clear Conmand Window
close all;  % Close all figure windows
clear all;  % Delete all existing varibales 
warning off; % turn off the warnings 
 
%% Detection of Pilot bits
 
d = arduino('com4', 'Uno');     % Create an Arduino object
count=0;        % Initial counter to 0
 
 
while (1)       % Infinite while loop to receive bits
    voltage= (readVoltage(d, 'A0'));    % Read voltae from  Analog pin  A0
    disp(voltage);      % Display the received voltage in float
        if (voltage >= 1)   % Condition to predict whether 1 or 0 is transmitted 
            count=1+count;  % Increment conuter 
            pause(1);
        end
        
        if count==7     % Condition to break the loop
            break;      % break infinite loop if counter is set to 8 (11111111)
        end
end
 
%% Main Processing
 %y =cell(8,1);
 count_letter = 1;
while (1) 
    for i=1:1:8
        voltage=(readVoltage(d, 'A0'));    % Read voltae from  Analog pin  A0
        %disp(voltage);       % Display the received voltage in float
        if (voltage >= 1)   % Condition to predict whether 1 or 0 is transmitted 
            a='1';
            pause(2);
        else 
            a='0';
            pause(2);   
        end
        %disp(a);
        y(i)=a;     % from a set of total 8 bits transmitted 
    end
    disp(y);
    temp = bin2dec(y);  % Convert  binary to decimal
    %fprintf('%s',char(temp));   %Convert decimal to characters and print the value
    letter(count_letter) = char(temp);
    count_letter = 1+count_letter;  % Increment conuter 
    
    if y == '00000000'      % Condition to Stop Reception, if no dat is beiong transmitted 
        disp('*****************************');
        disp('end of transmission');
        break; 
    end
    delete a;   
end  

disp('Received Characters are : ');
disp(letter);

function data = simpleRead(logfile)        
hold all; 
ser = serial('COM4');                             % this is the port the Ardunio is on
set(ser, 'BaudRate', 9600, 'Timeout', 0.005);     % 9600 is the serial intializing port, timeout is the max time to wait for data
fopen(ser);                                       % open the serial reader

finishup = onCleanup(@() cleanup(ser));           % removes remaining data from the serial reader                                                                                            
    function cleanup(s)
        fclose(s);                                % close the serial reader
        delete(s);                                % delete all information stored in the serial
        clear s                                   % remove data from MATLAB
        disp('Clean!')                            % tells you it cleaned: if it doesn't unplug and replug arduino
    end

fscanf(ser)                                             % pulls data from serial text file
valuesUnfiltered = [];
while(true)
    if(get(ser, 'BytesAvailable') >= 1)                 % if there is data coming in from the arduino
       
        value = sscanf(fscanf(ser), '%d,%u,%d');        % sscanf reads formatted data from string, fscanf reads data from the text file 
        valuesUnfiltered = cat(1, valuesUnfiltered,value);
        if (value == -1)                                % if the Ardunio prints -1 (you can change this case if you ned to!) , the scanning is done.
            break                                       % ... so you end the loop                                      
                   
        end
    end
end
valuesArray = zeros(3,((size(valuesUnfiltered,1))/3));
count = 1;
%% Running through our sensor data and breaking out the compents of base angle, top angle, and distance.
 for c = 1:3:((size(valuesUnfiltered,1)))
     CalibratedVal = 0.00027*valuesUnfiltered(c+1)^2-0.32*valuesUnfiltered(c+1)+120;
     disp(valuesUnfiltered(c));
     if(count<(size(valuesUnfiltered,1))/3)
        valuesArray(:,count) = [valuesUnfiltered(c+3);valuesUnfiltered(c+2); CalibratedVal];
     end
     count = count + 1
 end
data = valuesArray
sizeVal = size(valuesArray,2);
% colomap and bar
scatter3(valuesArray(1,:),valuesArray(2,:), valuesArray(3,:))
%colormap(jet);
% colorbar;
xlabel('X') % x-axis label
ylabel('Z') % y-axis label
zlabel('Y') % z-axis label
save(logfile, 'data');
end



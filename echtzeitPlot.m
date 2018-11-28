delete(instrfind);
clear;
serialPort = '/dev/cu.usbserial-AK05A8A6';
serialObject = serial(serialPort);
fopen(serialObject);
time=now;

stopTime = '11/28 14:54';
timeInterval = 0.0005;
count = 1;

figure('Name','Echtzeit Werte','NumberTitle','off');

while ~isequal(datestr(now,'mm/DD HH:MM'),stopTime)
    out = fscanf(serialObject)
    time(count) = datenum(clock);
    
    num = str2num(out)
   
    temp1(count)= num(2)
    temp2(count)= num(3)
    
    subplot(2,1,1)
    plot(time, temp1, '.-', 'LineWidth',1,'Color',[1 0 0]);
    hold on;
    plot(time, temp2, '.-', 'LineWidth',1,'Color',[0 1 0]);
    set(gca, 'Fontsize', 14, 'XLim', [min(time) max(time+0.001)]);
    ylabel 'Temperatur';
    datetick('x','HH:MM:SS');
    legend ('Temperatur 1','Temperatur 2');
    hold on;
    
    subplot(2,1,2)
    plot(time, temp2, '.-', 'LineWidth',1,'Color',[0 0 1]);
    set(gca, 'Fontsize', 14, 'XLim', [min(time) max(time+0.001)]);
    ylabel 'Waage';
    xlabel 'Zeit';
    datetick('x','HH:MM:SS');
    
    pause(timeInterval);
    count = count +1;
end

fclose(serialObject);
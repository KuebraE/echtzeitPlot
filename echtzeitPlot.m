delete(instrfind);
clear;
serialPort = '/dev/cu.usbserial-AK05A8A6';
serialObject = serial(serialPort);
fopen(serialObject);
       
timeInterval = 0.0005;
count = 1;
        
figure('Name','Echtzeit Werte','NumberTitle','off');
        
tic
while 1
    out = fscanf(serialObject)
    time(count) = toc;
    
    num = str2num(out)
    
    if isempty(num)
        break;
    end 
    
    temp1(count)= num(2)
    temp2(count)= num(3)
    weight(count)= num(4)
    sbStatus(count)= num(5)
    heaterStatus(count)= num(6)
    piValue(count)= num(7)
                
    %temperature
    subplot(2,3,[1,2])
    plot(time, temp1, '.-', 'LineWidth',1,'Color',[1 0 0]);
    hold on;
    plot(time, temp2, '.-', 'LineWidth',1,'Color',[0 1 0]);
    set(gca, 'Fontsize', 14,'XlimMode','manual','XLim', [min(time) max(time+0.001)]);
    ylabel 'Temperatur';
    %datetick('x','SS');
    legend ('Temperatur 1','Temperatur 2');
    hold on;
    
    %weight
    subplot(2,3,[4,5])
    plot(time, weight, '.-', 'LineWidth',1,'Color',[0 0 1]);
    set(gca, 'Fontsize', 14, 'XLim', [min(time) max(time+0.001)]);
    ylabel 'Waage';
    xlabel 'Zeit';
    %datetick('x','SS');

    %heaterstatus und sbStatus
    subplot(2,3,3)
    plot(time, heaterStatus, '.-', 'LineWidth',1,'Color',[0 0 1]);
    hold on;
    plot(time, sbStatus, '.-', 'LineWidth',1,'Color',[0 1 0]);
    set(gca, 'Fontsize', 14,'yTick',[0 1],'yTickLabel',{'OFF';'ON'},'YLim',[0 1],'XLim', [min(time) max(time+0.001)]);
    ylabel 'Status';
    xlabel 'Zeit';
    %datetick('x','SS');
    legend ('Heizpilz','SB-Status');
    hold on;

    %Heizleistung
    subplot(2,3,6)
    plot(time, piValue, '.-', 'LineWidth',1,'Color',[0 0 1]);
    set(gca, 'Fontsize', 14,'XLim', [min(time) max(time+0.001)]);
    ylabel 'Heizleistung';
    xlabel 'Zeit';
    %datetick('x','SS');

    pause(timeInterval); 
    count = count +1;
end

fclose(serialObject);

%Werte in TXT-Datei speichern             
T = table(temp1',temp2',weight', sbStatus', heaterStatus',piValue','VariableNames',{'Temperatur1','Temperatur2','Gewicht','SBStatus','Heizpilz','Heizleistung'});
filename = 'Data.txt'; 
writetable(T,filename)



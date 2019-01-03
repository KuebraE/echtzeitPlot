delete(instrfind);
clear;
serialPort = '/dev/cu.usbserial-AK05A8A6';
serialObject = serial(serialPort);
fopen(serialObject);

%men? anzeige 
i = 0;
data = {};
while ~isequal(i,4)
    menu= fgetl(serialObject);
    a = strsplit(menu, ':')
    data{end+1}= char(a(2));
    i=i+1;
end
disp(char(data))

%men? selection
selection = input('W?hle Men?punkt aus:');

switch selection 
    case 1 
        fprintf(serialObject, 49)
        out = fscanf(serialObject)
    case 2
        fprintf(serialObject, 50)
        out = fscanf(serialObject)
    case 3
        fprintf(serialObject, 51)
        out = fscanf(serialObject)
    case 4
        
        fprintf(serialObject, 52)
       
        timeInterval = 0.0005;
        count = 1;
        
        figure('Name','Echtzeit Werte','NumberTitle','off');
        
        tic
        while 1
                out = fscanf(serialObject)
                time(count) = toc;
    
                num = str2num(out)
   
                temp1(count)= num(2)
                temp2(count)= num(3)
                weight(count)= num(4)
                sbStatus(count)= num(5)
                heaterStatus(count)= num(6)
                %pwm(count)= num(7)
                
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
                %subplot(2,3,6)
                %plot(time, pwm, '.-', 'LineWidth',1,'Color',[0 0 1]);
                %set(gca, 'Fontsize', 14,'XLim', [min(time) max(time+0.001)]);
                %ylabel 'Heizleistung';
                %xlabel 'Zeit';
                %datetick('x','SS');

                pause(timeInterval);
                count = count +1;
        end

end

fclose(serialObject);

%Werte in TXT-Datei speichern             
%T = table(temp1',temp2',weight, sbStatus', heaterStatus','VariableNames',{'Temperatur1','Temperatur2','Gewicht','SBStatus','Heizpilz'});
%filename = 'Data.txt'; 
%writetable(T,filename)



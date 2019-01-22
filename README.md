# Real Time Plot in MATLAB 
Matlab can be used to read and plot data in real time via a serial port.

After the computer is connected to the board, execute the following command in the console:

    sudo cu -l /dev/cu.usbserial-AK05A8A6 -s 9600
    

A menu will appear with the following items: 

    1: Info
    2: Live-Monitoring 
    3: UART-HEATER Test
    4: Live Reporting

For plotting in Matlab the fourth option "Live Reporting" is selected. This executes a program which outputs the following data:
the values of two temperature sensors, the weight, the status of the heater, the status of the board and the heating power.
 
Subsequently, the script in Matlab can be executed, which generates the following figure with 4 graphs:

![Matlab-Figur](/praktikum.png){ width=50% }

In the first graph the values of two temperature sensors are plotted and in the second graph the values of the scale are plotted. In addition, the third graph shows the heater status and the status of the board. The last graph shows the heating power. 

If no more data is received, the read data are finally written to a text file and saved:

![Messwerte in Text-Datei](/textDatei.png){ width=50% }

## Serial Communication in Matlab 
First create a serial port object "serialObject" and associate it with the serial port. Before you can read data, "serialObject" must be connected to the device with the fopen function: 

    serialPort = '/dev/cu.usbserial-AK05A8A6';
    serialObject = serial(serialPort);
    fopen(serialObject);

When "serialObject" is connected to the device you can read Data. Data is read in a WHILE loop with the fscanf function: 

    out = fscanf(serialObject)

The elapsed time is determined with the functions tic and toc. tic starts a stopwatch timer and toc shows the elapsed time. 

If you finished with the read operation, disconnect "serialObject" with the fclos function: 

    fclose(serialObject)










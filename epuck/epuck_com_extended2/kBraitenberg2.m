function kBraitenberg2(ref,amb_steigung,amb_y_achsen_abschnitt,amb_kreuz,ir_steigung,ir_y_achsen_abschnitt,ir_kreuz)
global RUN

% if (nargin>4), IR_Sensor=1; end
licht_sensor=zeros(8,1);
objekt_sensor=zeros(8,1);
licht_faktor=504;
objekt_faktor=70;%max-wert 10 * 8mm/s
objekt_offset=1; %default speed is 5*8mm/s


while RUN==1
    %fear of walls and aggression towards light

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Auslesen der Lichtsensoren %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Wertebereich 0-504 ->504: dunkel ->0: hell, nur 1 bis 6
    pause(0.1)
    licht_sensor = kAmbient(ref);			
    % Mittelwert linke Lichtsensoren
    licht_sensor_links=licht_faktor/mean(licht_sensor(6:8));
    % Mittelwert rechte Lichtsensoren
    licht_sensor_rechts=licht_faktor/mean(licht_sensor(1:3));
    %display([licht_sensor_links licht_sensor_rechts]);

    % Transferfunktion Sensoren -> Aktuatoren
    transfer_fkt_licht_links=amb_steigung*licht_sensor_links + amb_y_achsen_abschnitt;
    transfer_fkt_licht_rechts=amb_steigung*licht_sensor_rechts + amb_y_achsen_abschnitt;
  %  display([transfer_fkt_licht_links transfer_fkt_licht_rechts]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Auslesen der IR-Sensoren %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Wertebereich 0-1023 -> 1023: nah ->0: fern, nur 1,2,5,6
    pause(0.1)
    objekt_sensor=kProximity(ref);
    % Mittelwert linke IR-Sensoren
    objekt_sensor_links=mean(objekt_sensor(7:8))/objekt_faktor;
    % Mittelwert rechte IR-Sensoren
    objekt_sensor_rechts=mean(objekt_sensor(1:2))/objekt_faktor;
 %   display([objekt_sensor_links objekt_sensor_rechts])

    % Transferfunktion Sensoren -> Aktuatoren
    transfer_fkt_objekt_links = ir_steigung * objekt_sensor_links + ir_y_achsen_abschnitt;
    transfer_fkt_objekt_rechts = ir_steigung * objekt_sensor_rechts + ir_y_achsen_abschnitt;
%    display([transfer_fkt_objekt_links transfer_fkt_objekt_rechts]);

    %%%%%%%%%%%%%%
    % Aktuatoren %
    %%%%%%%%%%%%%%
    if (amb_kreuz==0) % ungekreuzte Uebertragung
    % Motor links
        amb_speed(1) = transfer_fkt_licht_links;	       
    % Motor rechts
        amb_speed(2) = transfer_fkt_licht_rechts;
    else
    % Motor links
        amb_speed(1) = transfer_fkt_licht_rechts;	       
    % Motor rechts
        amb_speed(2) = transfer_fkt_licht_links;    
    end;

    if (ir_kreuz==0) % ungekreuzte Uebertragung
        % Motor links
        ir_speed(1) = transfer_fkt_objekt_links;	       
        % Motor rechts
        ir_speed(2) = transfer_fkt_objekt_rechts;
    else
        % Motor links
        ir_speed(1) = transfer_fkt_objekt_rechts;	       
        % Motor rechts
        ir_speed(2) = transfer_fkt_objekt_links;    
    end;

    speed(1) = amb_speed(1) + ir_speed(1); %amb_speed(1) + 
    speed(2) = amb_speed(2) + ir_speed(2); %amb_speed(2) + 
    
	kSetSpeed(ref,speed(1),speed(2));		% write the speed
end % while RUN=1

kSetSpeed(ref,0,0);

function kDrive(a,b,x)

%Aufruf: kDrive(l,r,ref), wobei l die Geschwindigkeit fuer das linke und r die fuer das rechte Rad bezeichne
 
     a=round(a);
     b=round(b);
     if(a>20)
        a=20;
end
     if(b>20)
        b=20;
     end
     stg=['D,',num2str(a),',',num2str(b) 10];
     ksend(stg,x);

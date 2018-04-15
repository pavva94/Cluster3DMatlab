function [] = disegnaConfrontiExam(d1,d2,d3,d4,d5,d6,d7)
    % funzione che disegna i 5 grafi utili per l'esame
    % i dati sono [p, e, p1, p2, p3, racs, e1, e2, e3, eRacs]
    % ogni variabile è lunga 100 quindi dati è lunga 1000
    % disegna i confronti tra i vari dati
    
    for i=1:7
        if i==1
            dati=d1;
        end
        if i==2
            dati=d2;
        end
        if i==3
            dati=d3;
        end
        if i==4
            dati=d4;
        end
        if i==5
            dati=d5;
        end
        if i==6
            dati=d6;
        end
        if i==7
            dati=d7;
        end
            
        p = dati(1:100);
        e = dati(101:200);
        figure(3);
        hold on;
        errorbar(p,e);
        title('Probabilità di Percolare')

        p1 = dati(201:300);
        e1 = dati(601:700);
        figure(4);
        hold on;
        errorbar(p1,e1);
        title('P1')

        p2 = dati(301:400);
        e2 = dati(701:800);
        figure(5);
        hold on;
        errorbar(p2,e2);
        title('P2')

        p3 = dati(401:500);
        e3 = dati(801:900);
        figure(6);
        hold on;
        errorbar(p3,e3);
        title('P3')

        racs = dati(501:600);
        eRacs = dati(901:1000);
        figure(7);
        hold on;
        errorbar(racs,eRacs);
        title('RACS')

    end
end
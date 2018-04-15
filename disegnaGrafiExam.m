function [] = disegnaGrafiExam(dati)
    % funzione che disegna i 5 grafi utili per l'esame
    % i dati sono [p, e, p1, p2, p3, racs, e1, e2, e3, eRacs]
    % ogni variabile è lunga 100 quindi dati è lunga 1000
    
    p = dati(1:100);
    e = dati(101:200);
    figure(3);
    
    subplot(2,3,1);
    errorbar(p,e);
    title('Probabilità di Percolare')
    
    p1 = dati(201:300);
    e1 = dati(601:700);
    subplot(2,3,2);
    errorbar(p1,e1);
    title('P1')
    
    p2 = dati(301:400);
    e2 = dati(701:800);
    subplot(2,3,3);
    errorbar(p2,e2);
    title('P2')
    
    p3 = dati(401:500);
    e3 = dati(801:900);
    subplot(2,3,4);
    errorbar(p3,e3);
    title('P3')
    
    racs = dati(501:600);
    eRacs = dati(901:1000);
    subplot(2,3,5);
    errorbar(racs,eRacs);
    title('RACS')
    
    subplot(2,3,6);
    hold on;
    errorbar(p2,e2);
    errorbar(p3,e3);
    title('P2-P3')

end
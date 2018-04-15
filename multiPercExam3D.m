function [MultiPperc, MultiErrPperc, MultimP1Perc, MultimP2Perc, MultimP3Perc, MultimRacsPerc, MultiErrP1Perc, MultiErrP2Perc, MultiErrP3Perc, MultiErrRacsPerc] = multiPercExam3D(L,pMin, pMax, pStep, N)
    % Programma per verificare se c'è percolazione N volte sull'intervallo
    % pMin - pMax di probabilità di colorazione del sito
    % L è la dimensione della mia matrice
    % PpMin è la probabilità di partenza
    % N è il numero di volte che devo provare.
    % pStep è lo step di avanzamento della probabilità

    % inizializzazione variabili
    % numero prove con p diverso
    if pMax < pMin
        return
    end
    if pMax == pMin
        deltaP = 1;
    else
        deltaP = floor((pMax-pMin)/pStep);
    end

    % variabili per la frequenza di percolare/valor medio e la sua varianza
    MultiPperc = zeros(1,deltaP);
    MultiErrPperc = zeros(1,deltaP);
    % MultivarPperc = zeros(1,deltaP);
    MultinClusterPerc = zeros(1,deltaP);
    
    % variabili per la media e la varianza di p1,p2,p3 e racs
    MultimP1Perc = zeros(1,deltaP);
    % MultivarP1Perc = zeros(1,deltaP);
    MultiErrP1Perc = zeros(1,deltaP);

    MultimP2Perc = zeros(1,deltaP);
    % MultivarP2Perc = zeros(1,deltaP);
    MultiErrP2Perc = zeros(1,deltaP);

    MultimP3Perc = zeros(1,deltaP);
    % MultivarP3Perc = zeros(1,deltaP);
    MultiErrP3Perc = zeros(1,deltaP);

    MultimRacsPerc = zeros(1,deltaP);
    % MultivarRacsPerc = zeros(1,deltaP);
    MultiErrRacsPerc = zeros(1,deltaP);
    
    % ripeto l'esperimento N volte con p variabile a step di 0.01
    for z=1:deltaP
        p = pMin+(pStep*(z-1))
        % mi salvo per ogni prova se ha percolato o no
        xPerc = zeros(1,N);
        nClusterPerc = zeros(1,N);
        % mi salvo per ogni prova le variabili p1,p2,p3,racs
        p1Perc = zeros(1,N);
        p2Perc = zeros(1,N);
        p3Perc = zeros(1,N);
        racsPerc = zeros(1,N);
    
        % ripeto l'esperimento della percolazione N volte per un p
        for i=1:N
            r = clusterExam3D(L, p);
            % prendiamo le etichette della prima e ultima riga di ogni
            % dimensione
            % dentro cOne ci metto le etichette dei cluster trovati nella prima
            % colonna di ogni dimensione
            cOne = [];
            % dentro cLast ci metto le etichette dei cluster trovati nella
            % ultima colonna di ogni dimensione
            cLast = [];
            for k=1:L
                % prendo le etichette dalla prima colonna
                uOne = unique(r.e(:, 1, k));
                % unique mi da la colonna, a me serve un vettore quindi faccio
                % questo for anche se non è bello
                uOneArray = [];
                for w=1:length(uOne)
                    uOneArray = [uOneArray uOne(w)];
                end
                cOne = [cOne uOneArray];

                % prendo le etichette dalla ultima colonna
                uLast = unique(r.e(:, end, k));
                uLastArray = [];
                for w=1:length(uLast)
                    uLastArray = [uLastArray uLast(w)];
                end
                cLast = [cLast uLastArray];
            end
            cOne = unique(cOne);
            cLast = unique(cLast);
            % elimino l'etichetta 0
            cOne(cOne==0) = [];
            cLast(cLast==0) = [];

            % salvo quante percolazioni ho avuto
            nPerc = 0;
            % verifichiamo se c'è intersezione tra le etichette
            for j=1:length(cOne)
                % ciclo le etichette dentro cOne e se la stessa etichetta è
                % dentro cLast allora c'è percolazione
                % quindi conto la percolazione
                if sum(cOne(j) == cLast)
                    nPerc = nPerc + 1;
                end
            end
            
            % controllo per gestire l'assenza di cluster
            if r.d
                % MI SALVO LE INFORMAZIONI UTILI ALL'ANALISI:
                maxCluster = max(r.d);
                numeroSiti = L*L*L; % cubo in 3D

                % 1. dimensione massima cluster / numero siti
                p1 = maxCluster/numeroSiti;

                % 2. dimensione massima cluster / (prob. colorazione * numero siti)
                p2 = maxCluster/(p*numeroSiti);

                % 3. dimensione massima cluster / somma su tutti i cluster(dim. 
                % cluster * # cluster di quella dimensione)
                sommaCluster = 0;
                for w = 1: max(unique(r.d))
                    sommaCluster = sommaCluster + sum(r.d==w)*w;
                end
                p3 = maxCluster/sommaCluster;

                % 4. RACS = somma su tutti i cluster diversi dal massimo(dimensione 
                % cluster * (dim cluster*# cluster di quella dimensione))
                % / somma su tutti i cluster(dim. cluster * # cluster di quella dimensione)
                racsNum = 0;
                for w = 1:(max(unique(r.d))-1)
                    racsNum = racsNum + w*(sum(r.d==w)*w);
                end
                racs = racsNum/sommaCluster;

                % mi salvo le info
                p1Perc(i) = p1;
                p2Perc(i) = p2;
                p3Perc(i) = p3;
                racsPerc(i) = racs;
            else
                p1Perc(i) = 0;
                p2Perc(i) = 0;
                p3Perc(i) = 0;
                racsPerc(i) = 0;
            end

            % 5. devo sapere se c'è percolazione o no
            if nPerc
                xPerc(i) = 1;
            end
            % 6. mantengo l'informazione di quanti cluster percolanti
            % sono stati creati
            nClusterPerc(i) = nPerc;
        end        
        % MI SALVO I DATI PER OGNI P
        
        % calcoliamo la frequenza di percolare, la sua varianza e il numero
        % di cluster percolanti medio
        MultiPperc(z) = mean(xPerc);
        %MultivarPperc(z) = var(xPerc)/N;
        MultiErrPperc(z) = std(xPerc)/sqrt(N);
        MultinClusterPerc(z) = mean(nClusterPerc);

        % calcoliamo la media e la varianza per p1,p2,p3 e racs e l'errore 
        MultimP1Perc(z) = mean(p1Perc);
        %MultivarP1Perc(z) = var(p1Perc)/N;
        MultiErrP1Perc(z) = std(p1Perc)/sqrt(N);

        MultimP2Perc(z) = mean(p2Perc);
        %MultivarP2Perc(z) = var(p2Perc)/N;
        MultiErrP2Perc(z) = std(p2Perc)/sqrt(N);

        MultimP3Perc(z) = mean(p3Perc);
        %MultivarP3Perc(z) = var(p3Perc)/N;
        MultiErrP3Perc(z) = std(p3Perc)/sqrt(N);

        MultimRacsPerc(z) = mean(racsPerc);
        %MultivarRacsPerc(z) = var(racsPerc)/N;
        MultiErrRacsPerc(z) = std(racsPerc)/sqrt(N);
    end
    
end
function [Pperc, varPperc] = multiPercExam(L,p,N)
    % L è il lato della mia matrice, P è la probabilità e N è il numero di
    % volte che devo provare.
    % programma per verificare se c'è percolazione
    
    % mi salvo per ogni prova se ha percolato o no
    xPerc = zeros(1,N);
    
    % ripeto l'esperimento della percolazione N volte
    for i=1:N
        r = clusterExam(L, p);
        % prendiamo le etichette della prima e ultima riga
        cOne = unique(r.e(:,1));
        cOne = cOne(find(cOne));
        cLast = unique(r.e(:,end));
        cLast = cLast(find(cLast));
        
        aux = 0;
        % verifichiamo se c'è intersezione tra le etichette
        for j=1:length(cOne)
            % se c'è intersezione conto come percolante il cluster
            if sum(cOne(j) == cLast)
                aux = aux + 1;
            end
        end
        
        % devo sapere se c'è percolazione o no
        if aux
            xPerc(i) = 1;
        end
    end
    % calcoliamo la frequenza di percolare/ valor medio
    Pperc = mean(xPerc);
    % e la sua varianza
    varPperc = var(xPerc)/N;

end
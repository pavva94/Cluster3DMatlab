function [Pperc, varPperc] = multiPercExam(L,p,N)
    % L � il lato della mia matrice, P � la probabilit� e N � il numero di
    % volte che devo provare.
    % programma per verificare se c'� percolazione
    
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
        % verifichiamo se c'� intersezione tra le etichette
        for j=1:length(cOne)
            % se c'� intersezione conto come percolante il cluster
            if sum(cOne(j) == cLast)
                aux = aux + 1;
            end
        end
        
        % devo sapere se c'� percolazione o no
        if aux
            xPerc(i) = 1;
        end
    end
    % calcoliamo la frequenza di percolare/ valor medio
    Pperc = mean(xPerc);
    % e la sua varianza
    varPperc = var(xPerc)/N;

end
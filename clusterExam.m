function M = clusterExam(N, p)
    % Ricerca di cluster all'interno di una matrice N*N con probabilità p
    % che un sito sia colorato
    % Ritorna una struttura dati:
    % .m è la matrice iniziale
    % .e è la matrice con le etichette
    % .d è un vettore con le dimensioni dei cluster trovati
    M.m = rand(N) < p;
    M.e = zeros(N);
    M.d = [];
    dim = N;
    % contiene la matrice degli indici
    I = reshape(1:N^2,dim,dim);
    % creo gli indici di vicini
    % destro
    nnr = [I(:,2:end) zeros(dim,1)];
    % sinistro
    nnl = [zeros(dim,1) I(:,1:end-1)];
    % su
    nnu = [zeros(1,dim); I(1:end-1,:)];
    % giu
    nnd = [I(2:end,:); zeros(1,dim)];
    % etichetta di partenza
    etichetta = 0;
  
    % ciclo tutti gli elementi della matrice
    for i = 1:N^2
        % alloco la memoria per la coda
        % all'interno della coda ci saranno gli indici vicini all'indice che
        % siamo valutando che dovranno essere valutati
        coda = zeros(1, N^2);
        
        % se l'elemento della matrice non è etichettato ed è valorizzato 1
        % procedo con la vlautazione
        if (~M.e(i) && M.m(i))
            % lunghezza coda
            len_coda = 1;
            % inizializzo la coda
            coda(len_coda) = i;
            % etichetta ++
            etichetta = etichetta + 1;
            % nella matrice delle etichette segno con l'etichetta corrente
            % il sito che sto valutando
            M.e(i) = etichetta;
            % inizializzo contatore coda
            j = 1;
            % ciclo la coda
            while j <= len_coda
                % estraggo sito dalla coda
                sito = coda(j);
                % se il sito sopra esiste, se il sito sopra è 1, se il sito
                % sopra non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnu(sito) && M.m(nnu(sito)) && ~M.e(nnu(sito))
                    % aumento la lunghezza della coda
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito sopra
                    coda(len_coda) = nnu(sito);
                    % assegno al sito sopra l'etichetta corrente
                    M.e(nnu(sito)) = etichetta;
                end
                % se il sito sotto esiste, è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnd(sito) && M.m(nnd(sito)) && ~M.e(nnd(sito))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito destro
                    coda(len_coda) = nnd(sito);
                    % assegno al sito giu l'etichetta corrente
                    M.e(nnd(sito)) = etichetta;
                end
                % se il sito sinistro esiste, se è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnl(sito) && M.m(nnl(sito)) && ~M.e(nnl(sito))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito sinistro
                    coda(len_coda) = nnl(sito);
                    % assegno al sito sinistro l'etichetta corrente
                    M.e(nnl(sito)) = etichetta;
                end
                % se il sito destro esiste, è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnr(sito) && M.m(nnr(sito)) && ~M.e(nnr(sito))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito destro
                    coda(len_coda) = nnr(sito);
                    % assegno al sito destro l'etichetta corrente
                    M.e(nnr(sito)) = etichetta;
                end
                % aumento l'indice della coda
                j = j + 1;
            end
            % aumento la dimensione del cluster
            M.d = [M.d, len_coda];
        end
    end
end
function M = clusterExam3D(N, p)
    % Ricerca di cluster all'interno di una matrice N*N con probabilità p
    % che un sito sia colorato
    % Ritorna una struttura dati:
    % .m è la matrice3D iniziale
    % .e è la matrice3D con le etichette
    % .d è un vettore con le dimensioni dei cluster trovati
    
    % Creo una matrice 3D N*N*N in cui visualizzo i siti secondo la
    % probabilita p
    d=zeros(N,N,N);
    M.m = [];
    for k=1:N
        d(:,:,k)=rand(N)<p;
    end
    M.m = d;
     % Creo una matrice 3D N*N*N in cui inserirò le etichette
    d=zeros(N,N,N);
    for k=1:N
        d(:,:,k)=0;
    end
    M.e = d;
    M.d = [];
    dim = N;
    % contiene la matrice degli indici
    I = reshape(1:N^3,dim,dim,dim);
    
    % etichetta di partenza
    etichetta = 0;
    % alloco la memoria per la coda
    % all'interno della coda ci saranno gli indici vicini all'indice che
    % siamo valutando che dovranno essere valutati
    coda = zeros(1, N^3);
    
    % ciclo tutti gli elementi della matrice
    for i = 1:N^3
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

                % creo i vicini per il sito che sto valutando
                % creo gli indici di vicini
                % destro
                nnr = [I(:, 2:end, ceil(sito/(N)^2)) zeros(dim, 1, 1)];
                % sinistro
                nnl = [zeros(dim,1,1) I(:, 1:end-1, ceil(sito/(N)^2))];
                % su
                nnu = [zeros(1,dim,1); I(1:end-1, :, ceil(sito/(N)^2))];
                % giu
                nnd = [I(2:end, :, ceil(sito/(N)^2)); zeros(1,dim,1)];
                % avanti (3D cioè verso il lettore)
                if ceil(sito/(N)^2)-1 > 0 && ceil(sito/(N)^2)-1 <= N
                    nna = I(:, :, ceil(sito/(N)^2)-1);
                else
                    nna = zeros(dim,dim);
                end
                % indietro (3D cioè verso il dentro dello schermo)
                if ceil(sito/(N)^2)+1 > 0 && ceil(sito/(N)^2)+1 <= N
                    nni = I(:, :, ceil(sito/(N)^2)+1);
                else
                    nni = zeros(dim,dim);
                end

                % per prendere l'indice corretto all'interno delle
                % tabelle di vicini devo prendere il sito 2D dal sito
                % 3D
                if sito >= N^2
                    sito2D = sito-N^2*(ceil(sito/N^2)-1);
                else
                    sito2D = sito;
                end

                % se il SITO SOPRA esiste, se il sito sopra è 1, se il sito
                % sopra non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnu(sito2D) && M.m(nnu(sito2D)) && ~M.e(nnu(sito2D))
                    % aumento la lunghezza della coda
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito sopra
                    coda(len_coda) = nnu(sito2D);
                    % assegno al sito sopra l'etichetta corrente
                    M.e(nnu(sito2D)) = etichetta;
                end

                % se il SITO SOTTO esiste, è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnd(sito2D) && M.m(nnd(sito2D)) && ~M.e(nnd(sito2D))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito destro
                    coda(len_coda) = nnd(sito2D);
                    % assegno al sito giu l'etichetta corrente
                    M.e(nnd(sito2D)) = etichetta;
                end

                % se il SITO SINISTRO esiste, se è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnl(sito2D) && M.m(nnl(sito2D)) && ~M.e(nnl(sito2D))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito sinistro
                    coda(len_coda) = nnl(sito2D);
                    % assegno al sito sinistro l'etichetta corrente
                    M.e(nnl(sito2D)) = etichetta;
                end

                % se il SITO DESTRO esiste, è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                if nnr(sito2D) && M.m(nnr(sito2D)) && ~M.e(nnr(sito2D))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito destro
                    coda(len_coda) = nnr(sito2D);
                    % assegno al sito destro l'etichetta corrente
                    M.e(nnr(sito2D)) = etichetta;
                end

                % se il SITO AVANTI esiste, è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                %sito
                if nna(sito2D) && M.m(nna(sito2D)) && ~M.e(nna(sito2D))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito destro
                    coda(len_coda) = nna(sito2D);
                    % assegno al sito destro l'etichetta corrente
                    M.e(nna(sito2D)) = etichetta;
                end

                % se il SITO INDIETRO esiste, è 1 e non ha etichetta
                % allora è un sito da valutare e lo inserisco nella coda
                %M.e(nni(sito))
                if nni(sito2D) && M.m(nni(sito2D)) && ~M.e(nni(sito2D))
                    len_coda = len_coda + 1;
                    % aggiungo alla coda il sito destro
                    coda(len_coda) = nni(sito2D);
                    % assegno al sito destro l'etichetta corrente
                    M.e(nni(sito2D)) = etichetta;
                end

                % aumento l'indice della coda
                j = j + 1;
            end
            % aumento la dimensione del cluster
            M.d = [M.d, len_coda];
        end
    end
    
end
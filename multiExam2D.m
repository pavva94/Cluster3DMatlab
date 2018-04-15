function [] = multiExam2D(N, T)
    % calcola la media di esecuzione della funzione f su T dimensioni
    % diverse
    
    figure(21);
    hold on;
    title("Probabilità percolazione 2D");
    for i=1:length(T)
        T(i)
        [p, e, p1, p2, p3, racs, e1, e2, e3, eRacs] = multiPercExam2D(T(i), 0, 1, .01, N);
        errorbar(p,e);
    end
end
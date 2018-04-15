function [multiTime] = multiTimeProbExam(L, p, N, T)
    % calcola la media di esecuzione della funzione f su T dimensioni
    % diverse
    multiTime = zeros(1,T);
    for i=1:T
        f = @() multiPercExam3D(L+i, p, p, .01, N);
        multiTime(i) = timeit(f);
    end
    
    figure(20);
    hold on;
    plot(multiTime);
    title("Tempi elaborazione L variabile");
end
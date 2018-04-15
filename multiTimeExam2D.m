function [multiTime] = multiTimeExam2D(N, T)
    % calcola la media di esecuzione della funzione f su T dimensioni
    % diverse
    multiTime = zeros(1,length(T));
    for i=1:length(T)
        T(i)
        tic; multiPercExam2D(T(i), 0, 1, .01, N);
        multiTime(i) = toc;
    end
    
    figure(21);
    hold on;
    plot(multiTime);
    title("Tempi elaborazione 2D");
end
function [multiTime] = multiTimeExam(L, p, N, T)
    % calcola la media di esecuzione della funzione f su T probabilità
    % diverse
    multiTime = zeros(1,T);
    for i=1:T
        f = @() multiPercExam3D(L, p+(i*.05), p+(i*.05), .01, N);
        multiTime(i) = timeit(f);
        if p+(i*.05) >= 1
            break
        end
    end
    
    figure(15);
    hold on;
    plot(multiTime);
    title("Tempi elaborazione P variabile");
end
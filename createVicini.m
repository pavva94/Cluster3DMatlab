function [] = createVicini(N)
    layer = 1;
    dim = N;
    I = reshape(1:N^3,dim,dim, dim);
    
    for i = 1:N^3
            if ceil(i/(N)^2) == layer
                % ricalcolo i vicini dato che ho cambiato layer
                % creo gli indici di vicini
                % destro
                nnr = [I(:, 2:end, ceil(i/(N)^2)) zeros(dim, 1, 1)];
                % sinistro
                nnl = [zeros(dim,1,1) I(:, 1:end-1, ceil(i/(N)^2))];
                % su
                nnu = [zeros(1,dim,1); I(1:end-1, :, ceil(i/(N)^2))];
                % giu
                nnd = [I(2:end, :, ceil(i/(N)^2)); zeros(1,dim,1)];
                % avanti (3D cioè verso il lettore)
                if ceil(i/(N)^2)-1 > 0 && ceil(i/(N)^2)-1 <= N
                    nna = I(:, :, ceil(i/(N)^2)-1)
                else
                    nna = zeros(dim,dim)
                end
                % indietro (3D cioè verso il dentro dello schermo)
                if ceil(i/(N)^2)+1 > 0 && ceil(i/(N)^2)+1 <= N
                    nni = I(:, :, ceil(i/(N)^2)+1)
                else
                    nni = zeros(dim,dim)
                end
                % aumento il layer
                layer = layer + 1;
            end
    end
end
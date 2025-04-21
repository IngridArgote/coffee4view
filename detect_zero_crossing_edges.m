function zero_cross_mask = detect_zero_crossing_edges(img_gray)
% img_gray debe ser una imagen en escala de grises (double en [0,1])
% Devuelve una máscara binaria con los cruzamientos por cero

    % 1. Suavizar la imagen con filtro Gaussiano
    smoothed = imgaussfilt(img_gray, 1.5);  % sigma = 1.5

    % 2. Aplicar filtro Laplaciano del Gaussiano (LoG)
    h = fspecial('log', [5 5], 1.5);
    log_response = imfilter(smoothed, h, 'replicate');

    % 3. Inicializar máscara de cruzamiento por cero
    [H, W] = size(log_response);
    zero_cross_mask = false(H, W);

    % 4. Detectar cambios de signo entre píxeles vecinos (8-direcciones)
    for i = 2:H-1
        for j = 2:W-1
            center = log_response(i,j);

            % Direcciones
            neighbors = [
                log_response(i-1,j), log_response(i+1,j);  % arriba-abajo
                log_response(i,j-1), log_response(i,j+1);  % izquierda-derecha
                log_response(i-1,j-1), log_response(i+1,j+1);  % diagonal ?
                log_response(i-1,j+1), log_response(i+1,j-1)   % diagonal ?
            ];

            for k = 1:size(neighbors,1)
                if sign(neighbors(k,1)) ~= sign(neighbors(k,2))
                    zero_cross_mask(i,j) = true;
                    break;
                end
            end
        end
    end

end


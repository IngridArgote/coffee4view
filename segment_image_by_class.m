function segmented_img = segment_image_by_class(img, className)
% segment_image_by_class - Segmenta frutos de una clase desde una imagen RGB
%
% Entradas:
%   img       - Imagen RGB
%   className - Nombre de la clase (debe existir en thresholds_all_classes.mat)
%
% Salida:
%   segmented_img - Imagen segmentada con solo la fruta de esa clase

% --- 1. Cargar umbrales preprocesados
load('thresholds_all_classes.mat', 'umbral_all', 'canales_all', 'pesos_all');

if ~isfield(umbral_all, className)
    error('La clase "%s" no está disponible en los umbrales cargados.', className);
end

selected_channels = canales_all.(className);
thresholds = umbral_all.(className);
weights = pesos_all.(className);

% --- 2. Preparar imagen
if ~isfloat(img)
    img = im2double(img);
end

img = enhance_contrast(img);  % aplicar la misma mejora usada en el entrenamiento

[H, W, ~] = size(img);
hsvImg = rgb2hsv(img);
labImg = rgb2lab(img);
ycbcrImg = rgb2ycbcr(img);

% --- 3. Preparar todos los canales de análisis
channel_data = struct();
channel_data.R  = img(:,:,1);
channel_data.G  = img(:,:,2);
channel_data.B  = img(:,:,3);
channel_data.H  = hsvImg(:,:,1);
channel_data.S  = hsvImg(:,:,2);
channel_data.V  = hsvImg(:,:,3);
channel_data.L  = labImg(:,:,1) / 100;
channel_data.a  = mat2gray(labImg(:,:,2));
channel_data.b  = mat2gray(labImg(:,:,3));
channel_data.Y  = mat2gray(ycbcrImg(:,:,1));
channel_data.Cb = mat2gray(ycbcrImg(:,:,2));
channel_data.Cr = mat2gray(ycbcrImg(:,:,3));

% --- 4. Inicializar máscara ponderada
final_mask_score = zeros(H, W);

for i = 1:length(selected_channels)
    ch = selected_channels{i};
    C = channel_data.(ch);
    Q1 = thresholds.(ch)(1);
    Q3 = thresholds.(ch)(2);

    mask = (C >= Q1) & (C <= Q3);
    final_mask_score = final_mask_score + weights(i) * double(mask);
end

% --- 5. Binarizar y limpiar máscara final
final_mask = final_mask_score > 0.01;

% ? Procesamiento morfológico
final_mask = imopen(final_mask, strel('disk', 2));  % quitar ruido
final_mask = imclose(final_mask, strel('disk', 4)); % cerrar huecos
final_mask = imfill(final_mask, 'holes');           % rellenar interior

% --- 6. Aplicar máscara a la imagen original
segmented_img = img;
for k = 1:3
    ch = segmented_img(:,:,k);
    ch(~final_mask) = 0;
    segmented_img(:,:,k) = ch;
end

% --- 7. Visualización
figure; imshow(img); title(['Imagen Original - Clase: ', className]);
figure; imshow(final_mask); title(['Máscara Binaria - Clase: ', className]);
figure; imshow(segmented_img); title(['Fruto Segmentado - Clase: ', className]);

% --- 8. Guardar máscara
filename = ['mask_', className, '_', datestr(now, 'yyyymmdd_HHMMSS'), '.png'];
imwrite(final_mask, filename);
fprintf('? Máscara guardada como: %s\n', filename);

end

%% === Función de mejora de contraste
function out = enhance_contrast(img)
    lab = rgb2lab(img);
    L = lab(:,:,1)/100;
    L_eq = adapthisteq(L, 'NumTiles', [8 8], 'ClipLimit', 0.01);
    lab(:,:,1) = L_eq * 100;
    out = lab2rgb(lab);
end


function [hasil] = mainglcm(knn)
   
    fileLatih = 'CiriLatih.txt';
    fileKelas = 'KelasCiri.txt';
    ciriLatih = csvread(fileLatih);
    kelasCiri = csvread(fileKelas);
    kelasCiri = kelasCiri(:);
    D1 = 'E:\GLCM-KUKU\DataUji\b'; %image dari android disimpan disini
    imagetest = dir(fullfile(D1,'gambar.jpeg'));
    uji = imread(fullfile(D1,imagetest.name));
      
    %ubah K disini
    k = 1;

    %Training
    train = fitcknn(ciriLatih,kelasCiri,'NumNeighbors',k,'Standardize',1);
    ukuran = imresize(uji, [224 224]);
    dataUji = rgb2gray(uji);
    glcmUji = graylevel_comat(dataUji);
    %Predict
    [label,score,cost] = predict(train,glcmUji);
    
    if label == 1
        hasil = 'Terrys';
      else
        hasil = 'Sehat';
    end

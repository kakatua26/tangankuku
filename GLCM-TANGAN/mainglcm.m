function [hasil] = mainglcm(knn)
    
    fileLatih = 'CiriLatih.txt';
    fileKelas = 'KelasCiri.txt';
    ciriLatih = csvread(fileLatih);
    kelasCiri = csvread(fileKelas);
    kelasCiri = kelasCiri(:);
    D1 = 'D:\Danny\GLCM-TANGAN\DataUji'; %image dari android disimpan disini
    imagetest = dir(fullfile(D1,'gambar.jpg'));
    uji = imread(fullfile(D1,imagetest.name));
    
    
    %ubah K disini
    k = knn;

    %Training
    train = fitcknn(ciriLatih,kelasCiri,'NumNeighbors',k,'Standardize',1);
    
    dataUji = rgb2gray(uji);
    glcmUji = graylevel_comat(dataUji);
    %Predict
    [label,score,cost] = predict(train,glcmUji);

    if label == 0
        hasil = 'SEHAT';
    else
        hasil = 'HFMD';
    end
end
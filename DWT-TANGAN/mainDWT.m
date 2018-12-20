function [hasil] = mainDWT(knn)
    
    D1 = 'D:\TUGAS AKHIR 2.0\PENGUJIAN LEVEL 1\DataUji'; %ini gambar dari android
    imagetest = dir(fullfile(D1,'gambar.jpg')); %ini gambar dari android
    uji = imread(fullfile(D1,imagetest.name));
    
    fileLatih = 'ciriLatih.txt';
    fileKelas = 'kelasCiri.txt';
    ciriLatih = csvread(fileLatih);
    kelasCiri = csvread(fileKelas);
    kelasCiri = kelasCiri(:);
    
    k = 5;
    
    %training
    train = fitcknn(ciriLatih,kelasCiri,'NumNeighbors',k,'Standardize',1);
    
    dataUji = double(rgb2gray(uji));
    [cA,cH,cV,cD] = ekstrakDWT(dataUji);

    %==========================================
    %cA level 1
    cA=cA(:);
    mean_cA = sum(cA)/length(cA);
    cAmean = [];
    for j=1:length(cA)
        cAmean = [cAmean; (cA(j)-mean_cA)*(cA(j)-mean_cA)];
    end
    cAvarian = sum(cAmean)/length(cA);
    SD_cA = sqrt(cAvarian);

    %cH level 1
    cH=cH(:);
    mean_cH = sum(cH)/length(cH);
    cHmean = [];
    for j=1:length(cH)
        cHmean = [cHmean; (cH(j)-mean_cH)*(cH(j)-mean_cH)];
    end
    cHvarian = sum(cHmean)/length(cH);
    SD_cH = sqrt(cHvarian);

    %cV level 1
    cV=cV(:);
    mean_cV = sum(cV)/length(cV);
    cVmean = [];
    for j=1:length(cV)
        cVmean = [cVmean; (cV(j)-mean_cV)*(cV(j)-mean_cV)];
    end
    cVvarian = sum(cVmean)/length(cV);
    SD_cV = sqrt(cVvarian);

    %cD level 1
    cD=cD(:);
    mean_cD = sum(cD)/length(cD);
    cDmean = [];
    for j=1:length(cD)
        cDmean = [cDmean; (cD(j)-mean_cD)*(cD(j)-mean_cD)];
    end
    cDvarian = sum(cDmean)/length(cD);
    SD_cD = sqrt(cDvarian);

    %===================
    ciriUji = [mean_cA SD_cA mean_cH SD_cH mean_cV SD_cV mean_cD SD_cD]; 
    %predict
    [label,score,cost] = predict(train,ciriUji);

    if label == 0
        hasil = 'HFMD';
    else
        hasil = 'SEHAT';
    end
end

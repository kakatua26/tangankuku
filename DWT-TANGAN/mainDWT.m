function [hasil] = mainDWT(knn)
    
    D1 = 'D:\Danny\bas\DataUji'; %image dari android disimpan disini
    imagetest = dir(fullfile(D1,'gambar.jpg'));
    uji = imread(fullfile(D1,imagetest.name));
    
    fileLatih = 'ciriLatih.txt';
    fileKelas = 'kelasCiri.txt';
    ciriLatih = csvread(fileLatih);
    kelasCiri = csvread(fileKelas);
    kelasCiri = kelasCiri(:);
    
    k = knn;
    
    %training
    train = fitcknn(ciriLatih,kelasCiri,'NumNeighbors',k,'Standardize',1);
    
    dataUji = double(rgb2gray(uji));
    [cA,cH,cV,cD] = ekstrakDWT(dataUji);
    [cA1,cH1,cV1,cD1] = ekstrakDWT(cA);
    
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

    %============================
    %cA1 level 2
    cA1=cA1(:);
    mean_cA1 = sum(cA1)/length(cA1);
    cA1mean = [];
    for j=1:length(cA1)
        cA1mean = [cA1mean; (cA1(j)-mean_cA1)*(cA1(j)-mean_cA1)];
    end
    cA1varian = sum(cA1mean)/length(cA1);
    SD_cA1 = sqrt(cA1varian);

    %cH1 level 2
    cH1=cH1(:);
    mean_cH1 = sum(cH1)/length(cH1);
    cH1mean = [];
    for j=1:length(cH1)
        cH1mean = [cH1mean; (cH1(j)-mean_cH1)*(cH1(j)-mean_cH1)];
    end
    cH1varian = sum(cH1mean)/length(cH1);
    SD_cH1 = sqrt(cH1varian);

    %cV1 level 2
    cV1=cV1(:);
    mean_cV1 = sum(cV1)/length(cV1);
    cV1mean = [];
    for j=1:length(cV1)
        cV1mean = [cV1mean; (cV1(j)-mean_cV1)*(cV1(j)-mean_cV1)];
    end
    cV1varian = sum(cV1mean)/length(cV1);
    SD_cV1 = sqrt(cV1varian);

    %cD1 level 2
    cD1=cD1(:);
    mean_cD1 = sum(cD1)/length(cD1);
    cD1mean = [];
    for j=1:length(cD1)
        cD1mean = [cD1mean; (cD1(j)-mean_cD1)*(cD1(j)-mean_cD1)];
    end
    cD1varian = sum(cD1mean)/length(cD1);
    SD_cD1 = sqrt(cD1varian);
    %===================
    ciriUji = [mean_cA SD_cA mean_cH SD_cH mean_cV SD_cV mean_cD SD_cD mean_cA1 SD_cA1 mean_cH1 SD_cH1 mean_cV1 SD_cV1 mean_cD1 SD_cD1];
    
    %predict
    [label,score,cost] = predict(train,ciriUji);

    if label == 0
        hasil = 'HFMD';
    else
        hasil = 'SEHAT';
    end
end
function hasil = mainSURF(knn)
    D1 = 'D:\SURF-TANGAN\DataUji'; %image dari android disimpan disini
    imagetest = dir(fullfile(D1,'gambar.jpg'));
    uji = imread(fullfile(D1,imagetest.name));
    k = 5;
    
    fileLatih = 'ciriLatih.txt';
    fileKelas = 'kelasCiri.txt';
    ciriLatih = csvread(fileLatih);
    kelasCiri = csvread(fileKelas);
    kelasCiri = kelasCiri(:);
    %==========
    train = fitcknn(ciriLatih,kelasCiri,'NumNeighbors',k,'Standardize',1);
    %==========
    %Extract Test file from dataUji folder
    dataUji = im2double(imresize(uji,[700 600]));
    dataUji = rgb2gray(dataUji);
    % Get the Key Points
    Options.upright=true;
    Options.tresh=0.0009;
    SurfExtract = ExtractSURF(dataUji,Options);
    FeatureVec = reshape([SurfExtract.descriptor],64,[]);
    rng(1)
    klaster = kmeans(FeatureVec,25,'Distance','cityblock');
    panjang = length(klaster);
    Testfeatures = reshape(klaster, [1 panjang]);
    % tempUji = detectSURFFeatures(dataUji);
    % [im_features, temp] = extractFeatures(dataUji, temp);
    % features = im_features(:);
    % panjang = length(features);
    
    [label,score,cost] = predict(train,Testfeatures);
    
    % 
    if label == 0
        hasil = 'HFMD';
    else
        hasil = 'BUKAN HFMD';
    end
end

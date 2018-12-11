function hasil = LatihData()
    clc;
    D = 'D:\Danny\SURF-TANGAN\DataLatih';
    
    %image={im2double(imresize(imread('tangan01.jpg'),[256 256]));};
    imagetrains =  dir(fullfile(D,'*.jpg'));
    nfiles=length(imagetrains);
    ciriLatih = [];
    kelasCiri = [];
    
    %files={f.name}; 

    %=================
    %Train all files in dataTrain Folder
    for ii=1:nfiles 
        % Load images
        image=im2double(imresize(imread(fullfile(D,imagetrains(ii).name)),[700 600]));
        image=rgb2gray(image);
        I2=image; 

        % Get the Key Points
        Options.upright=true;
        Options.tresh=0.0001;
        SurfExtract = ExtractSURF(I2,Options);

        % Put the landmark descriptors in a matrix
        %D1 = reshape([Ipts1.descriptor],64,[]);
        FeatureVec = reshape([SurfExtract.descriptor],64,[]);
        klaster = kmeans(FeatureVec,3,'Distance','cityblock');
        %features = D2(:);
        panjang = length(klaster);
        features = reshape(klaster, [1 panjang]);
        ciriLatih = [ciriLatih; features];
        if ii<47
            kelasCiri = [kelasCiri 0];
        else
            kelasCiri = [kelasCiri 1];
        end
    end
    csvwrite('ciriLatih.txt',ciriLatih);
    csvwrite('kelasCiri.txt',kelasCiri);
end

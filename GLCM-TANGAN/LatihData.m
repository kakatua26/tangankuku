clc;
D = 'D:\Danny\GLCM-TANGAN\DataLatih';
imagetrains =  dir(fullfile(D,'*.jpg'));
nfiles=length(imagetrains);
ciriLatih = [];
kelasCiri = [];

%Loop Data Latih
for ii=1:nfiles
    imagetrains(ii).name;
    gambarIni = fullfile(D,imagetrains(ii).name);
    ini_ajah = imread(gambarIni);
    grayImage = rgb2gray(ini_ajah);
    if ii<100
        kelasCiri = [kelasCiri 0];
    else
        kelasCiri = [kelasCiri 1];
    end

       glcm = graylevel_comat(grayImage);
       ciriLatih = [ciriLatih; glcm];
end

csvwrite('CiriLatih.txt',ciriLatih);
csvwrite('KelasCiri.txt',kelasCiri);
%------------
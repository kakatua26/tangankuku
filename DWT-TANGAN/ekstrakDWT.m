function [cA,cH,cV,cD] = ekstrakDWT(img)
    img = imresize(img, [700,600]);
    %[Lo,Hi] = wfilters('haar','d');
    %filter = [Lo;Hi];
    Lo = [0.7071 0.7071]
    Hi = [-0.7071 0.7071]
    ukuran = size(img);
    hasilFilt = [];
    D2 = zeros(ukuran);

    %Dekomposisi Kolom dengan Filter LH 
    for i=1:ukuran(2)
        HasKolm = [];
        kolom = img(:,i);
        ind = 0;
        for j=1:length(kolom)
            ind = ind + 1;
            if ind == 1
                vKolom = [kolom(j);kolom(j+1)];
                Lfilt = Lo*vKolom;
                HasKolm = [HasKolm; Lfilt];
            elseif ind == 2
                vKolom = [kolom(j-1);kolom(j)];
                Hfilt = Hi*vKolom;
                HasKolm = [HasKolm; Hfilt];
                ind = 0;
            end
        end
        D2(:,i) = HasKolm;
    end

    %D3 %Merupakan Hasil Dekomposisi Kolom
    D3 = [];
    Apr = 1;
    for i=1:(ukuran(1)/2)
        D3 = [D3; D2(Apr,:)];
        Apr = Apr + 2;
    end
    Det = 2;
    for i=1:(ukuran(1)/2)
        D3 = [D3; D2(Det,:)];
        Det = Det + 2;
    end

    %Dekomposisi Baris dengan Filter LH
    D4 = zeros(ukuran);
    for i=1:ukuran(1)
        HasBrs = [];
        Baris = D3(i,:);
        Baris = Baris(:);
        ind = 0;
        for j=1:length(Baris)
            ind = ind + 1;
            if ind == 1
                vBaris = [Baris(j);Baris(j+1)];
                Lfilt = Lo*vBaris;
                HasBrs = [HasBrs Lfilt];
            elseif ind == 2
                vBaris = [Baris(j-1);Baris(j)];
                Hfilt = Hi*vBaris;
                HasBrs = [HasBrs Hfilt];
                ind = 0;
            end
        end
        D4(i,:) = HasBrs;
    end

    %D5 Merupakan Hasil dekomposisi baris pada D3
    D5 = zeros(ukuran);
    Apr = 1;
    for i=1:(ukuran(2)/2)
        D5(:,i) = D4(:,Apr);
        Apr = Apr + 2;
    end
    Det = 2;
    uk = ukuran(2)/2;
    for i=uk+1:(ukuran(2))
        D5(:,i) = D4(:,Det);
        Det = Det + 2;
    end

    acuBawah = ukuran(1)/2;
    acuAtas = ukuran(2)/2;
    cA = D5((1:acuBawah),(1:acuAtas));
    cH = D5((1:acuBawah),(acuAtas+1:ukuran(2)));
    cV = D5((acuBawah+1:ukuran(1)),(1:acuAtas));
    cD = D5((acuBawah+1:ukuran(1)),(acuAtas+1:ukuran(2)));
end

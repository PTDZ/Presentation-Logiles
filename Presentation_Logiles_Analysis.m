%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ANALIZA POJEDYNCZY PLIK BADANEGO %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
% Will be explained later; set of individual data of individual subjects
ParticipantsSet = {E_EEG, I_EEG, J_EEG};
ParticipantsSet = transpose(ParticipantsSet);    

%% Analiza 
% Nowe kolumny - kategoria bodŸca, poprawna odpowiedŸ, dok³adna próba
for k = 1:length(ParticipantsSet)
    Var_1 = ParticipantsSet{k};
    for i = 1:length(Var_1)

        A = Var_1{i,4}; % sprawdzam co jest w 4 kolumnie
        B = convertStringsToChars(A); % zamieniam na chars

        if numel(B) == 5 % jesli ma 5 znakow to jest to czego szukam - kod proby
            categ = B(1); categ = str2num(categ);
            g_ans = B(2); g_ans = str2num(g_ans);
            g_sampl = B(3:5);
            Var_1{i,6} = categ; % wypisuje tylko kategorie
            Var_1{i,7} = g_ans; % wypisuje poprawna odpowiedz
            Var_1{i,8} = g_sampl; % wypisuje caly kod proby
        end 
    end
    ParticipantsSet{k} = Var_1;
end

clearvars A B categ g_ans g_sampl Var_1 k i
%% Wypisanie udzielonej odpowiedzi w kolumnie 9

for k = 1:length(ParticipantsSet)
    
    Var_1 = ParticipantsSet{k};
    licznik = 1;
    for i = 1:length(Var_1)


        A = Var_1{i,4}; % sprawdzam co jest w 4 kolumnie
        B = convertStringsToChars(A); % zamieniam na chars
        
        if numel(B) == 5 % jesli ma 5 znakow to chce komorke nizej jesli ma 1 znak
        
        AN = Var_1{i+1,4};
        Czas_AN = Var_1{i+1,5};
        BN = convertStringsToChars(AN);
        
        AN2 = Var_1{i+2,4};
        Czas_AN2 = Var_1{i+2,5};
        BN2 = convertStringsToChars(AN2);

            if numel(BN) == 1
                BN = str2num(BN); Var_1{i,9} = BN;
                                  Var_1{i,11} = Czas_AN;
            elseif numel(BN2) == 1
                BN2 = str2num(BN2); Var_1{i,9} = BN2;
                                    Var_1{i,11} = Czas_AN2;
            else
                Var_1{i,9} = [];
            end
        end 
    end
 ParticipantsSet{k} = Var_1;
 clearvars licznik i A B j C D B 
end

clearvars Var_1 k AN AN2 BN BN2 Czas_AN Czas_AN2


%% Poprawnoœæ udzielonych odpowiedzi - 1 poprawna, 0 - niepoprawna - kolumna 10
for k = 1:length(ParticipantsSet)
    
    Var_1 = ParticipantsSet{k};
    
    for i = 1:length(Var_1)

        powinna = Var_1{i,7};
        udzielona = Var_1{i,9};
        EmptyOrNot = isempty(powinna);

        if EmptyOrNot == false
                if powinna == udzielona
                    Var_1{i,10} = 1; % poprawna odpowiedz
                else
                    Var_1{i,10} = 0; % niepoprawna odpowiedz
                end    
        else
            Var_1{i,10} = [];
        end

    end
ParticipantsSet{k} = Var_1;
end

clearvars A B categ Var_1 k i j licznik powinna udzielona EmptyOrNot

%% Obliczenie czasu reakcji - kolumna 12
for k = 1:length(ParticipantsSet)   
   
    Var_1 = ParticipantsSet{k};
    
    for i = 1:length(Var_1)  
        Var_1{i,12} = Var_1{i,11} - Var_1{i,5};
    end
    
    ParticipantsSet{k} = Var_1;
end

clearvars A B categ Var_1 k i j D C licznik E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ANALIZA ZBIORCZA %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Nowa tabela - wyniki zbiorcze
% nazwa badanego, liczba powtorzen wszystkich, liczba poprawnych odpowiedzi
% wszystkich; liczba powtorzen dla 1, dla 2, dla 3; liczba poprawnych odp
% dla 1, 2 i 3
for k = 1:length(ParticipantsSet)   
   
%1 Kolumna - nazwa badanego
    Var_1 = ParticipantsSet{k};
    SummaryTable{k,1} = Var_1{1,1}; % nazwa badanego 1 kolumna

%2 Kolumna - Suma wszystkich odpowiedzi
    suma = 0;
    for i=1:length(Var_1)
        if Var_1{i,6} == 1 | 2 | 3
            suma = suma + 1;
        end
    end   
    SummaryTable{k,2} = suma;

    clearvars i suma

%3 Kolumna -  Suma poprawnych dla wszystkich
    suma = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1
            suma = suma + 1;
        end
    end   
    SummaryTable{k,3} = suma;

    clearvars suma i

%5 Kolumna - Suma wszystkich z kategorii 3 EASY

    suma = 0;
    for i=1:length(Var_1)
        if Var_1{i,6} == 3
            suma = suma + 1;
        end
    end   
    SummaryTable{k,5} = suma;

    clearvars i suma
    
%6 Kolumna - Suma wszystkich z kategorii 1 MIDI

    suma = 0;
    for i=1:length(Var_1)
        if Var_1{i,6} == 1
            suma = suma + 1;
        end
    end   
    SummaryTable{k,6} = suma;

    clearvars i suma

%7 Kolumna - Suma wszystkich z kategorii 2 HARD

    suma = 0;
    for i=1:length(Var_1)
        if Var_1{i,6} == 2
            suma = suma + 1;
        end
    end   
    SummaryTable{k,7} = suma;

    clearvars i suma
    
%8 Kolumna - Suma poprawnych dla kategorii 3 EASY
 
   suma = 0;
   suma_RT=0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,6} == 3
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
            proste{i,1} = Var_1{i,12};
        end
    end   
    SummaryTable{k,8} = suma;
    SummaryTable{k,14} = (suma_RT)/(suma)/(10); %zeby miec ms dziele na 10
    
    proste2 = proste(~cellfun('isempty',proste));
    proste2 = cell2mat(proste2);    
    SummaryTable{k,17} = std(proste2)/(10); %zeby miec ms dziele na 10

    clearvars suma i suma_RT proste proste2 
    
%9 Kolumna - Suma poprawnych dla kategorii 1 MIDI
 
    suma = 0;
    suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,6} == 1
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
            proste{i,1} = Var_1{i,12};
        end
    end   
    SummaryTable{k,9} = suma;
    SummaryTable{k,15} = (suma_RT)/(suma)/(10);
    
    proste2 = proste(~cellfun('isempty',proste));
    proste2 = cell2mat(proste2);    
    SummaryTable{k,18} = std(proste2)/(10); %zeby miec ms dziele na 10

    clearvars suma i suma_RT proste proste2 
    
%10 Kolumna - Suma poprawnych dla kategorii 2 HARD
 
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,6} == 2
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
            proste{i,1} = Var_1{i,12};
        end
    end   
    SummaryTable{k,10} = suma;
    SummaryTable{k,16} = (suma_RT)/(suma)/(10);
    
    proste2 = proste(~cellfun('isempty',proste));
    proste2 = cell2mat(proste2);    
    SummaryTable{k,19} = std(proste2)/(10); %zeby miec ms dziele na 10

    clearvars suma i suma_RT proste proste2 

%20 Kolumna - Suma wszystkich z kategorii 4 MIDI+

    suma = 0;
    for i=1:length(Var_1)
        if Var_1{i,6} == 4
            suma = suma + 1;
        end
    end   
    SummaryTable{k,20} = suma;

    clearvars i suma
    
%21 Kolumna - Suma poprawnych dla kategorii 4 MIDI+
 
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,6} == 4
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
            proste{i,1} = Var_1{i,12};
        end
    end   
    SummaryTable{k,21} = suma;
    SummaryTable{k,22} = (suma_RT)/(suma)/(10);
    
    proste2 = proste(~cellfun('isempty',proste));
    proste2 = cell2mat(proste2);    
    SummaryTable{k,23} = std(proste2)/(10); %zeby miec ms dziele na 10

    clearvars suma i suma_RT proste proste2     
end

%% Czas reakcji dla kolejnych prób

for k = 1:length(ParticipantsSet)    
    
    Var_1 = ParticipantsSet{k};
    SummaryTableSingle{k,1} = Var_1{1,1}; % nazwa badanego 1 kolumna
    ParticipantsSet{k} = Var_1;
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '100'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,1} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '020'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,2} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT     
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '003'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,3} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT   
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '122'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,4} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT   
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '133'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,5} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '121'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,6} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '323'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,7} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '113'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,8} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
 
        
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '223'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,9} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  

            
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '311'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,10} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '131'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,11} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '322'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,12} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '232'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,13} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  

   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '212'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,14} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '221'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,15} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '331'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,16} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '313'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,17} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '211'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,18} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT  
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '112'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,19} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '332'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,20} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '233'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,21} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 

% nowe nowe nowe nowe nowe nowe
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '010'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,22} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '001'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,23} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '200'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,24} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '002'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,25} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '300'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,26} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
    
   suma = 0;
   suma_RT = 0;
    for i=1:length(Var_1)
        if Var_1{i,10} == 1 & Var_1{i,8} == '030'
            suma = suma + 1;
            suma_RT = suma_RT + Var_1{i,12};
        end
    end   
    SummaryTableSingle{k,27} = (suma_RT)/(suma);
    
    clearvars suma i suma_RT 
end

%% Poza pêtl¹ z K 

%4 Kolumna - B³êdne odpowiedzi 
    for i=1:length(SummaryTable)
       SummaryTable{i,4} = SummaryTable{i,2} - SummaryTable{i,3};
    end   
    clearvars suma i
%%    
 %11 Kolumna - Procent poprawnych dla kategorii 1,2,3
     for i=1:length(SummaryTable)
       SummaryTable{i,11} = (SummaryTable{i,8} * 100)/(SummaryTable{i,5});
       SummaryTable{i,12} = (SummaryTable{i,9} * 100)/(SummaryTable{i,6});
       SummaryTable{i,13} = (SummaryTable{i,10} * 100)/(SummaryTable{i,7});
    end   
    clearvars i
 
    
%% Tytuly kolumn

for i=1:length(SummaryTable)
    [m,n] = size(SummaryTable);
    
    for j=1:n      
        SummaryTableP{i+1,j} = SummaryTable{i,j};
    end
    
end

%% Tytuly kolumn
SummaryTableP{1,1} = "Badany";
SummaryTableP{1,2} = "Triale ALL";
SummaryTableP{1,3} = "Poprawne ALL";
SummaryTableP{1,4} = "Bledne ALL";
SummaryTableP{1,5} = "EASY";
SummaryTableP{1,6} = "MIDI";
SummaryTableP{1,7} = "HARD";
SummaryTableP{1,8} = "EASY POPRA";
SummaryTableP{1,9} = "MIDI POPRA";
SummaryTableP{1,10} = "HARD POPRA";

SummaryTableP{1,11} = "EASY POPRA %";
SummaryTableP{1,12} = "MIDI POPRA %";
SummaryTableP{1,13} = "HARD POPRA %";

SummaryTableP{1,14} = "SREDNI RT EASY";
SummaryTableP{1,15} = "SREDNI RT MIDI";
SummaryTableP{1,16} = "SREDNI RT HARD";

SummaryTableP{1,14} = "SREDNI RT EASY";
SummaryTableP{1,15} = "SREDNI RT MIDI";
SummaryTableP{1,16} = "SREDNI RT HARD";

%% Œrednia ze œredniej czasów reakcji - dla wszystkich
suma1 = 0; suma2 = 0; suma3 = 0; suma4 = 0; suma5 = 0; suma6 = 0;

[m,n] = size(SummaryTable);
 
for i=1:m      
    suma1 = suma1 + SummaryTable{i,14};    
    suma2 = suma2 + SummaryTable{i,15}; 
    suma3 = suma3 + SummaryTable{i,16}; 

    suma4 = suma4 + SummaryTable{i,17};    
    suma5 = suma5 + SummaryTable{i,18}; 
    suma6 = suma6 + SummaryTable{i,19}; 
end
 
SummaryTable{m+1,14} = (suma1)/(m);
SummaryTable{m+1,15} = (suma2)/(m);
SummaryTable{m+1,16} = (suma3)/(m);

SummaryTable{m+1,17} = (suma4)/(m);
SummaryTable{m+1,18} = (suma5)/(m);
SummaryTable{m+1,19} = (suma6)/(m);

clearvars suma1 suma2 suma3 suma4 suma5 suma6 i m n 

%% wyjac wszystkich do jednej struktury; usun¹æ puste

T = cell2table(ParticipantsSet);
%

%%

emptycells = cellfun(@isempty, ParticipantsSet);    %find empty cells in the whole cell array
ParticipantsSet(any(emptycells(:, [2]), 2), :) = []; %remove rows for which any of column 6 or 9 is empty




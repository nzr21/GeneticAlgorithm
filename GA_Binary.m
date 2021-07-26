clear all
clc
n=input('Enter population value  =');
r=input('Enter selection value  =');
z=10/(2^10);
k=(2^10);
secilimyontemi=input('Please choose selection method  (roulette=1, rank=2 and tournament=3) =');
kromozomlar=logical(dec2bin(0:k-1,10)-'0');

% Function >>> F(x,y)=A*x+B*y+C*sin(x)+D*cos(y);
A=input('Specify the coefficient A =');
B=input('Specify the coefficient B ='); 
C=input('Specify the coefficient C =');
D=input('Specify the coefficient D =');
x=(10*rand(1,n));
y=10*rand(1,n)-5;


% Real Number
for i=1:n
    F(i)=A*x(i)+B*y(i)+C*sin(x(i))+D*cos(y(i));
end

%Binary Number
%F(x,y)=A*x+B*y+C*sin(x)+D*cos(y);
xindis=round(k*rand(1,n));
yindis=round(k*rand(1,n));
xbin=0:z:10;
ybin=-5:z:5;
for j=1:n
    Fx(j)=xbin(xindis(j));
    Fxbinary(j,:)=kromozomlar(xindis(j),:);
    Fy(j)=ybin(yindis(j));
    Fybinary(j,:)=kromozomlar(yindis(j),:);
    Fbin(j)=A*Fx(j)+B*Fy(j)+C*sin(Fx(j))+D*cos(Fy(j));
end
plot (Fbin(:,:))
xlabel('Population Value')
title('Function Graph')

secimtoplami=0;
for j=1:n
    secimtoplami=secimtoplami+Fbin(j); % sum of the proper values of n numbers 
end
for j=1:n
    uygunlukoranlari(j)=Fbin(j)/secimtoplami; % Unit sum of fitness values of n numbers 
end

kumilatiftoplam(1)=uygunlukoranlari(1);
for j=2:n
    kumilatiftoplam(j)=uygunlukoranlari(j)+kumilatiftoplam(j-1); % Cumulative sum of n fitness values 
end
for k=1:n
Fx(k);
Fy(k);
Fxbinary(k,:);
Fybinary(k,:);
uygunlukoranlari(k);
end
Fx
Fy
Fxbinary
Fybinary
uygunlukoranlari

%Roulette difference
if secilimyontemi==1
    
secimrulet=rand(1,r); %A number as many as the number in the r suitability range between 0-1 is selected
for i=1:r
    for j=1:n
    if secimrulet(i)<kumilatiftoplam(j)
        secilimoranlari(i)=kumilatiftoplam(j);
        Fxsecilim(i)=Fx(j);
        Fysecilim(i)=Fy(j);
        Fxbinarysecilim(i,:)=Fxbinary(j,:);
        Fybinarysecilim(i,:)=Fybinary(j,:);
        
        %fprintf('The most suitable number for roulette =%f\n',kumilatiftoplam(j));
        break;
    end
    end
end

 %Rank   
 elseif secilimyontemi==2
     
%Ranking of Eligibility Rates 
for i=1:(n)
for j=1:(n-i)
if uygunlukoranlari(j)>uygunlukoranlari(j+1)
gecici=uygunlukoranlari(j);
gecicix=Fx(j);
geciciy=Fy(j);
gecicixbin=Fxbinary(j,:);
geciciybin=Fybinary(j,:);
uygunlukoranlari(j)=uygunlukoranlari(j+1);
Fx(j)=Fx(j+1);
Fy(j)=Fy(j+1);
Fxbinary(j,:)=Fxbinary(j+1,:);
Fybinary(j,:)=Fybinary(j+1,:);
uygunlukoranlari(j+1)=gecici;
Fx(j+1)=gecicix;
Fy(j+1)=geciciy;
Fxbinary(j+1,:)=gecicixbin;
Fybinary(j+1,:)=geciciybin;
end
end
end
for k=1:n
uygunlukoranlari(k);
end
uygunlukoranlari

%Arithmetic numbers are assigned to fitness values. 
sayitoplami=0;
for k=1:n
rankuygunluk(k)=k;
sayitoplami=sayitoplami+k;
end

for k=1:n
rankuygunlukoran(k)=(rankuygunluk(k)/sayitoplami);
end
rankkumilatiftoplam(1)=rankuygunlukoran(1);
for j=2:n
    rankkumilatiftoplam(j)=rankuygunlukoran(j)+rankkumilatiftoplam(j-1); % Cumulative sum of n fitness values 
end

secimrank=rand(1,r); 

%-----------------
for i=1:r
    for j=1:n
    if secimrank(i)<rankkumilatiftoplam(j)
        secilimoranlari(i)=rankkumilatiftoplam(j); 
        Fxsecilim(i)=Fx(j);
        Fysecilim(i)=Fy(j);
        Fxbinarysecilim(i,:)=Fxbinary(j,:);
        Fybinarysecilim(i,:)=Fybinary(j,:);
        
        break;
    end
    end
end

else secilimyontemi==3
    
%Tournament selection 
for i=1:r
    secimtur=round(1+(n-1)*rand(1,2)); %1-n arasinda iki adet rastgale sayi �retme    
    if uygunlukoranlari(secimtur(1))>uygunlukoranlari(secimtur(2))
        fprintf('the number with the highest selection from the eligibility values in the tournament=%f\n',uygunlukoranlari(secimtur(1)));
        secilimoranlari(i)=uygunlukoranlari(secimtur(1));
        Fxsecilim(i)=Fx(secimtur(1));
        Fysecilim(i)=Fy(secimtur(1));
        Fxbinarysecilim(i,:)=Fxbinary(secimtur(1),:);
        Fybinarysecilim(i,:)=Fybinary(secimtur(1),:);
    else
        fprintf('the number with the highest selection from the eligibility values in the tournament=%f\n',uygunlukoranlari(secimtur(2)));
        secilimoranlari(i)=uygunlukoranlari(secimtur(2));
        Fxsecilim(i)=Fx(secimtur(2));
        Fysecilim(i)=Fy(secimtur(2));
        Fxbinarysecilim(i,:)=Fxbinary(secimtur(2),:);
        Fybinarysecilim(i,:)=Fybinary(secimtur(2),:);
    end 
end
end
for i=1:r
    for j=1:10
    ebeveyn(i,j)=Fxbinarysecilim(i,j);
    ebeveyn(i,j+10)= Fybinarysecilim(i,j);
    end
end

%crossover
caprazlamayontemi=input('Please select the crossover method  (odd point=1, even point=2) =');

%If the selection is an even number 
if mod(r,2)==0 

if caprazlamayontemi==1    
    %Single point crossover 
    teknokta=round(2+17*rand(1,1));  %Generating a random number between 2-19 
   
    for k=1:r %Parents are divided into two according to a odd point determined. 
        ebeveynx(k,:)=ebeveyn(k,1:teknokta);
        ebeveyny(k,:)=ebeveyn(k,(teknokta+1:20));
    end
    
    for i=1:2:r
        cocuklar(i,1:teknokta)=ebeveynx(i,1:teknokta);
        cocuklar(i,(teknokta+1):20)=ebeveyny((i+1),1:(20-teknokta));
    end
    for i=2:2:r
        cocuklar(i,1:teknokta)=ebeveynx(i,1:teknokta);
        cocuklar(i,(teknokta+1):20)=ebeveyny((i-1),1:(20-teknokta));
    end
else caprazlamayontemi==2
    
    %Double point crossover
    ciftnokta=round(2+17*rand(1,2));  %Generating a random number between 2-19 
    if ciftnokta(1)>ciftnokta(2)|ciftnokta(1)==ciftnokta(2)
        ciftnokta=round(2+17*rand(1,2));
    end
    
    for k=1:r %Parents are divided into two according to a even point determined. 
        ebeveynx(k,:)=ebeveyn(k,1:ciftnokta(1));
        ebeveyny(k,:)=ebeveyn(k,((ciftnokta(1)+1):ciftnokta(2)));
        ebeveynz(k,:)=ebeveyn(k,(ciftnokta(2)+1):20);
    end
    for i=1:2:r
        cocuklar(i,1:ciftnokta(1))=ebeveynx(i,1:ciftnokta(1));
        cocuklar(i,(ciftnokta(1)+1):ciftnokta(2))=ebeveyny((i+1),1:(ciftnokta(2)-ciftnokta(1)));
        cocuklar(i,(ciftnokta(2)+1):20)=ebeveynz(i,1:(20-ciftnokta(2)));
    end
    for i=2:2:r
        cocuklar(i,1:ciftnokta(1))=ebeveynx(i,1:ciftnokta(1));
        cocuklar(i,(ciftnokta(1)+1):ciftnokta(2))=ebeveyny((i-1),1:(ciftnokta(2)-ciftnokta(1)));
        cocuklar(i,(ciftnokta(2)+1):20)=ebeveynz(i,1:(20-ciftnokta(2)));
    end
end

%If selection is ODD number
else 
    if caprazlamayontemi==1  
 %Single point crossover
    teknokta=round(2+17*rand(1,1));  %Generating a random number between 2-19 
    
    for k=1:r-1 %Parents are divided into two according to a odd point determined. 
        ebeveynx(k,:)=ebeveyn(k,1:teknokta);
        ebeveyny(k,:)=ebeveyn(k,(teknokta+1:20));
    end
    
    for i=1:2:r-1
        cocuklar(i,1:teknokta)=ebeveynx(i,1:teknokta);
        cocuklar(i,(teknokta+1):20)=ebeveyny((i+1),1:(20-teknokta));
    end
    for i=2:2:r-1
        cocuklar(i,1:teknokta)=ebeveynx(i,1:teknokta);
        cocuklar(i,(teknokta+1):20)=ebeveyny((i-1),1:(20-teknokta));
    end
    else caprazlamayontemi==2
    
    %Double point crossover
    ciftnokta=round(2+17*rand(1,2));  %Generating a random number between 2-19 
    if ciftnokta(1)>ciftnokta(2)|ciftnokta(1)==ciftnokta(2)
        ciftnokta=round(2+17*rand(1,2));
    end
    
    for k=1:r-1 %Parents are divided into two according to a even point determined. 
        ebeveynx(k,:)=ebeveyn(k,1:ciftnokta(1));
        ebeveyny(k,:)=ebeveyn(k,((ciftnokta(1)+1):ciftnokta(2)));
        ebeveynz(k,:)=ebeveyn(k,(ciftnokta(2)+1):20);
    end
    for i=1:2:r-1
        cocuklar(i,1:ciftnokta(1))=ebeveynx(i,1:ciftnokta(1));
        cocuklar(i,(ciftnokta(1)+1):ciftnokta(2))=ebeveyny((i+1),1:(ciftnokta(2)-ciftnokta(1)));
        cocuklar(i,(ciftnokta(2)+1):20)=ebeveynz(i,1:(20-ciftnokta(2)));
    end
    for i=2:2:r-1
        cocuklar(i,1:ciftnokta(1))=ebeveynx(i,1:ciftnokta(1));
        cocuklar(i,(ciftnokta(1)+1):ciftnokta(2))=ebeveyny((i-1),1:(ciftnokta(2)-ciftnokta(1)));
        cocuklar(i,(ciftnokta(2)+1):20)=ebeveynz(i,1:(20-ciftnokta(2)));
    end
    end
cocuklar(r,:)=ebeveyn(r,:);
end

%MUTATION
%sorting is done and the best individuals are selected. 
for i=1:(n)
for j=1:(n-i)
if F(j)>F(j+1)
gecici=F(j);
gecicix=Fxbinary(j);
geciciy=Fybinary(j);
F(j)=F(j+1);
Fxbinary(j)=Fxbinary(j+1);
Fybinary(j)=Fybinary(j+1);
F(j+1)=gecici;
Fxbinary(j+1)=gecicix;
Fybinary(j+1)=geciciy;
end
end
end
for i=(r+1):n
    cocuklar(i,1:10)=Fxbinary(i,:);
    cocuklar(i,11:20)=Fybinary(i,:);
end
mutasyondegeri=1/n;
for i=1:n
    for j=1:20
    mutasyonorani=rand(1,1); %Selecting a number between 0-1 
       if mutasyonorani<mutasyondegeri
          if cocuklar(i,j)==0
              cocuklar(i,j)=1;
          else cocuklar(i,j)==1;
              cocuklar(i,j)=0;
          end
       end
    end
end

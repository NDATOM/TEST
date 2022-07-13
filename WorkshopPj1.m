askKorea="한국 원화 단위 얼마 있으신가요?";
x = input(askKorea);
country=struct;
country.name=["미국","유럽","일본","중국"];
country.exchangeRate=[0.00081, 0.00075 , 0.1,0.0052];
country.moneyName=[" 달러"," 유로"," 엔"," 위안"];

exchange(x,country);

function money=exchange(x,country)
    for i = 1:1:4
          money=x*country.exchangeRate(i);
          disp(country.name(i)+" 총 : "+money+country.moneyName(i)+" 입니다");
          moneyPaper(i, money)
    end
end

function moneyReturn=moneyPaper(countryNum,moneyTotal)
 countryNum=int8(countryNum);
 switch countryNum
    case 1
       sum = 0;
       sum = sum + fix(moneyTotal/100);
       r = rem(moneyTotal,100);
       sum = sum + fix(r/50);
       r = rem(r,50);
       sum = sum + fix(r/20);
       r = rem(r,20);
       sum = sum + fix(r/10);
       r = rem(r,10);
       sum = sum + fix(r/5);
       r = rem(r,5);
       sum = sum + fix(r/2);
       r = rem(r,2);
       sum = sum + fix(r/1);
       disp(" 총 : "+sum+" 개의 화폐가 필요합니다");
    case 2
         sum = 0;
       sum = sum + fix(moneyTotal/500);
       r = rem(moneyTotal,500);
       sum = sum + fix(r/200);
       r = rem(r,200);
       sum = sum + fix(r/100);
       r = rem(r,100);
       sum = sum + fix(r/50);
       r = rem(r,50);
       sum = sum + fix(r/20);
       r = rem(r,20);
       sum = sum + fix(r/10);
       r = rem(r,10);
       sum = sum + fix(r/5);
       disp(" 총 : "+sum+" 개의 화폐가 필요합니다");
    case 3
         sum = 0;
       sum = sum + fix(moneyTotal/10000);
       r = rem(moneyTotal,10000);
       sum = sum + fix(r/5000);
       r = rem(r,5000);
       sum = sum + fix(r/2000);
       r = rem(r,2000);
       sum = sum + fix(r/1000);
       disp(" 총 : "+sum+" 개의 화폐가 필요합니다");
    case 4
         sum = 0;
       sum = sum + fix(moneyTotal/100);
       r = rem(moneyTotal,100);
       sum = sum + fix(r/50);
       r = rem(r,50);
       sum = sum + fix(r/20);
       r = rem(r,20);
       sum = sum + fix(r/10);
       r = rem(r,10);
       sum = sum + fix(r/5);
       r = rem(r,5);
       sum = sum + fix(r/1);
       disp(" 총 : "+sum+" 개의 화폐가 필요합니다");
 end
end
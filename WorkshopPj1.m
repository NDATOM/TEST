askKorea="한국 원화 단위 얼마 있으신가요?";
x = input(askKorea);

% while 1%fgfgfgfg
%     askCountry="환전하려는 국가는 어디신가요? (1=미국, 2=유럽, 3=일본 4=중국)";
%     y= input(askCountry);
%     if (y>=1 && y<=4 && (y-int8(y)==0))
%         break;
%     end
%     disp("(1=미국, 2=유럽, 3=일본 4=중국) 중에 선택해주세요");
% end

% 1미국 0.00081  2유럽 1328.88 3일본 9.72 4중국 192.91

exchange(x);

function money=exchange(x)
    exchangeRate=[0.00081, 1328.88 , 9.72,192.91];
    exchangeCountry=["미국","유럽","일본","중국"];
    exchangeName=[" 달러"," 유로"," 엔"," 위안"];
    for i = 1:1:4
          money=x*exchangeRate(i);
          disp(exchangeCountry(i)+" 총 : "+money+exchangeName(i)+" 입니다");
          moneyPaper(i, money)
    end
end

function moneyReturn=moneyPaper(countryNum,moneyTotal)
 switch countryNum
    case '1'
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
       disp(" 총 : "+sum+"의 화폐가 필요합니다");
    case '2'
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
       disp(" 총 : "+sum+"의 화폐가 필요합니다");
    case '3'
         sum = 0;
       sum = sum + fix(moneyTotal/10000);
       r = rem(moneyTotal,10000);
       sum = sum + fix(r/5000);
       r = rem(r,5000);
       sum = sum + fix(r/2000);
       r = rem(r,2000);
       sum = sum + fix(r/1000);
       disp(" 총 : "+sum+"의 화폐가 필요합니다");
    case '4'
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
       disp(" 총 : "+sum+"의 화폐가 필요합니다");
 end

end
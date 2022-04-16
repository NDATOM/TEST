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
%sfsgdfgsdf
exchange(x);%hong%04162031


function money=exchange(x)
    exchangeRate=[0.00081, 1328.88 , 9.72,192.91];
    exchangeCountry=["미국","유럽","일본","중국"];
    exchangeName=[" 달러"," 유로"," 엔"," 위안"];
    for i = 1:1:4
          money=x*exchangeRate(i);
          disp(exchangeCountry(i)+" 총 : "+money+exchangeName(i)+" 입니다");
%           moneyPaper(i, money)
    end
end

function moneyReturn=moneyPaper(countryNum,moneyTotal)
    
end
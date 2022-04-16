askKorea="한국 원화 단위 얼마 있으신가요?";
x = input(askKorea);

while 1%fgfgfgfg
    askCountry="환전하려는 국가는 어디신가요? (1=미국, 2=유럽, 3=일본 4=중국)";
    y= input(askCountry);
    if (y>=1 && y<=4 && (y-int8(y)==0))
        break;
    end
    disp("(1=미국, 2=유럽, 3=일본 4=중국) 중에 선택해주세요");
end

% 1미국 0.00081  2유럽 1328.88 3일본 9.72 4중국 192.91

exchange(x,y);%hong%04162031

function money=exchange(x,y)
    switch y
        case 1
            money=x*0.00081;
            disp("총"+money+"달러 입니다");
        case 2
            money=x*1328.88;
            disp("총"+money+"유로 입니다");
        case 3
            money=x*9.72;
            disp("총"+money+"엔 입니다");
        case 4
            money=x*192.91;
            disp("총"+money+"위안 입니다");
    end%ghjgk
end
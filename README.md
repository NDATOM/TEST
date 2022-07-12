# 대회 진행 전략
대회 맵 구성은 다음과 같다.
> 1단계: 1-3m 이동하여 링 통과, 링에서 1m 뒤에 있는 표식에서 90도 회전
>    > 2단계: 1-3m 이동하면서 상하/앞뒤/좌우 변경된 링 통과, 링에서 1m 뒤에 있는 표식에서 120-150도 사이 회전
>    >    > 3단계: 1-3m 이동하면서 상하/앞뒤/좌우/각도 변경된 링 통과, 링에서 1m 뒤에 있는 표식에서 착지  
<Br>

채점 1순위는 링 통과 개수 및 착지 여부(단계 통과 여부), 2순위는 시간이다.


     이때, 시간을 초과하지 않고 통과해야 단계를 통과했다고 인정한다.

> * 1단계 링: 60초     
>> * 2단계 링: 90초 
>>> * 3단계 링: 130초 
>>>> * 착지: 20초


> 총 시간: 5분
    
<br>
     
### 1단계 전략 
드론을 띄우고, 전진하면서 표식을 찾는다. 그리고 90도 회전한다.
### 2단계 전략
전진 후 파란 링의 중심을 찾고, 다시 전진하면서 표식을 찾는다. 그리고 90도 회전한다.
### 3단계 전략
전진 후 45도 회전, 중심을 찾고 각도 조절 후 다시 중심을 찾는다. 그리고 전진 후 표식을 찾고 착지한다.
     
<br>
     
**대회 맵 구성과 비슷한 환경을 만들어 연습**<br>
![KakaoTalk_20220711_113637715](https://user-images.githubusercontent.com/103032180/178187069-9ce6c275-917b-4d44-9b45-9b5c5327a93e.jpg)



# 알고리즘 설명 및 소스코드 설명

# 1단계 알고리즘 및 소스코드 설명
드론 이륙 후,
```matlab
         image=snapshot(cameraObj);
%     imshow(image);
%     imageHSV=rgb2hsv(image);
%     image1H = imageHSV(:,:,1);
%     image1S = imageHSV(:,:,2);
%     image1V = imageHSV(:,:,3);
% 
     imageR_H = image1H <= 0.01 | image1H >= 0.97;
%     imageR_S = image1S >= 0.95 & image1S <= 1.0;
%     imageR_V = image1V >= 0.38 & image1V <= 0.41;
%     imageR_combi = imageR_H & imageR_S & imageR_V;

    image1R = image(:,:,1);
    image1G = image(:,:,2);
    image1B = image(:,:,3);

    image_only_R=image1R-image1G/2-image1B/2;
    bw = image_only_R > 55;
    
    image_only_B=image1B-image1R/2-image1G/2;
    bw2 = image_only_B > 55;
    [row2, col2] = find(bw2);

    imshow(bw2);
    stats = regionprops(bw);
    centerIdx=1;
    redOn=0;
    red_close=0;
    disp('length(row2) = ');
    disp(length(row2));
     
```
빨간색의 h, s, v 값, regionprops로 빨간색 표식의 속성을 찾는다.
     
```matlab
     
    if(~isempty(stats))
        for i = 1:numel(stats)
        
            if stats(i).Area > 3000
                disp("stage = 2");
                pause(1);
                stage1image=bw;
                turn(droneobj, deg2rad(90));
                pause(0.5);
                moveforward(droneobj,'WaitUntilDone',true,'distance',0.5);
%                 moveforward(droneobj,'WaitUntilDone',true,'distance',0.6);
                stage = 2;
                break;
            end

            if stats(i).Area > 1000
                red_close=1;
            end
        end
        if red_close==1
            moveforward(droneobj,'WaitUntilDone',true,'distance',0.3);
            disp("moveforward 0.4 slow");
        else
            moveforward(droneobj,'WaitUntilDone',true,'distance',0.5);
            disp("moveforward 0.4 fast");
        end

        redOn=1;
    end

    if red_close==1 && stage==1
        moveforward(droneobj,'WaitUntilDone',true,'distance',0.2);
        disp("moveforward 0.4 slow not box");
    elseif redOn==0 && stage==1
        moveforward(droneobj,0.8,'WaitUntilDone',true,'Speed',1);
        disp("moveforward 1");
    end

end
```
드론이 보는 표식의 크기에 따라 가까운지 먼지 판단하고, moveforward로 지정된 시간 동안 지정된 추가 옵션에 따라 직진하게 한다.

# 2단계 알고리즘 및 소스코드 설명
5가지 경우를 반복한다. 

### 첫 번째: 화면에 링의 파란 부분이 꽉 찼을 때 중앙점을 찾고 통과
- 원과 원의 중심을 검출해내고, 원의 중심과의 차이에 따라 중심으로 이동

<br>

링을 검출하는 알고리즘은 다음과 같다.

```matlab
    image=snapshot(cameraObj);
    nRows = size(image, 1);
    nCols = size(image, 2);

    image1R = image(:,:,1);
    image1G = image(:,:,2);
    image1B = image(:,:,3);

    image_only_B=image1B-image1R/2-image1G/2;
    bw = image_only_B > 55;
    bw_origin=bw;

    stats = regionprops(bw);   
    centerIdx=1;

    if(~isempty(stats)) 
        for i = 1:numel(stats)
            if stats(i).Area>stats(centerIdx).Area
                centerIdx=i; 
            end
        end
        rectangle('Position', stats(centerIdx).BoundingBox, ...
            'Linewidth', 3, 'EdgeColor', 'b', 'LineStyle', '--');

        bw(stats(centerIdx).BoundingBox(2):stats(centerIdx).BoundingBox(2)+stats(centerIdx).BoundingBox(4),stats(centerIdx).BoundingBox(1):stats(centerIdx).BoundingBox(1)+stats(centerIdx).BoundingBox(3))=1;
    end
    [row_origin, col_origin] = find(bw_origin); //bw_origin=bw;

    [row, col] = find(bw);
```
드론 이미지에서, 파란색 성분만을 검출한다.<br>
regionprops 함수로 속성 세트를 측정한다.<br>
가장 큰 면적을 찾는다.<br>
rectangle 함수로 사각형을 그린다.<br>
BOX 안을 모두 흰색(1)으로 만든다.<br>


<br>
중심을 찾는 알고리즘은 다음과 같다.

```matlab
            image=snapshot(cameraObj);
            image1R = image(:,:,1);
            image1G = image(:,:,2);
            image1B = image(:,:,3);
        
            image_only_B=image1B-image1R/2-image1G/2;
            bw = image_only_B > 55;
            bw=~bw; 
        
            bw = imerode(bw,se); 
    
            [row, col] = find(bw);
        
            rf=mean(row); 
            cf=mean(col);
            viscircles([cf rf],3);
```
드론 이미지에서, 파란색 성분만을 검출<br>
반전시킨 뒤, imerode 함수로 원의 노이즈를 제거 <br>
mean 함수로 중심값을 찾는다.

<br>
중심으로 이동하는 알고리즘은 다음과 같다.

```matlab
     error_r=rf-360;
            error_c=cf-480;
            
            down1=bw;
            
            disp(error_r);

            
            if abs(error_r)<100 || downCount==2 % 1m 에서 -30
                disp('if abs(error_r)<100');
                break;
            end
            downCount=downCount+1;
            movedown(droneobj,'WaitUntilDone',true);
        end
        goCount=0;
        while 1
            goCount=goCount+1;
            if goCount<2 % 한번 하강
                moveforward(droneobj,0.8,'WaitUntilDone',true,'Speed',1);
            else
                moveforward(droneobj,0.8,'WaitUntilDone',true,'Speed',0.8);
            end

             bw=~bw_origin; % 원형만 남게 
        
            bw = imerode(bw,se);
    
            [row, col] = find(bw);
        
            rf=mean(row);
            cf=mean(col);
            viscircles([cf rf],3);
   
            error_c=cf-480; 
             
            if abs(error_c)>margin2_full+10 %양옆 판단, 에러가 특정 margin 밖에 있고 row가 맞춰지지 않았을 때 좀더 널널하게 판단
                if error_c>0
                    disp('right go');
                    moveright(droneobj,'WaitUntilDone',true,'Distance',0.2);
                else
                    disp('left go');
                    moveleft(droneobj,'WaitUntilDone',true,'Distance',0.2);
                end
            end
```
찾은 중심값과 드론 전체화면의 중심과 비교하여 이동 <br>
이때, 드론의 최소 이동거리 20cm 문제로 중심점을 정확하게 맞추는 것이 어려우므로 margin값  


```matlab
     if (length(row) < 50 || length(col) < 50)
```
중심을 찾았다면, 전진 후 빨간색 표식의 크기로 종료 지점을 확인
     
     
### 두 번째: 화면에 링의 파란 부분이 꽉 차지 않았을 때 중앙점을 찾고 통과
- 원과 원의 중심을 검출해내고, 원의 중심과의 차이에 따라 중심으로 이동

첫 번째 경우와 다른 부분은 전진하는 코드가 있다는 것이다.
     
### 세 번째: 화면에 링의 파란 부분이 꽉 찼을 때 통과

이때, 안정적으로 중심을 찾기 위한 알고리즘을 만들었다.

```matlab
 if abs(error_r)>margin2_full_ud  %위아래 판단, 에러가 특정 margin 밖에 있고, Col을 맞출 때
            if error_r>0
                disp('down full');
               movedown(droneobj,'WaitUntilDone',true);
            else
                disp('up full');
              moveup(droneobj,'WaitUntilDone',true);
            end
        else
            disp('stop up down full');
            UDIn_full=UDIn_full+1;
        end
%%
        if abs(error_c)>margin2_full  %양옆 판단, 에러가 특정 margin 밖에 있고 row가 맞춰지지 않았을 때
            if error_c>0
                disp('right full');
                moveright(droneobj,'WaitUntilDone',true);
            else
                disp('left full');
                moveleft(droneobj,'WaitUntilDone',true);
            end
        else
            disp('stop right left full');
            RLIn_full=RLIn_full+1;
        end
% 양옆 혹은 위아래 하나만 중심을 찾았을 때
        if RLIn_full~=UDIn_full
            center_reset=1;
        end
        
        if center_reset==1
            UDIn_full=0;
            RLIn_full=0;
            center_reset=0;
        end
        
        if RLIn_full > 2 && UDIn_full > 2 
            fullgo=1;
            disp('fullgo=1');
        end
```
     
     
### 네 번째: 화면에 링의 파란 부분이 꽉 차지 않았을 때 통과



### 다섯 번째: 예외 상황
파랑색이 존재하지 않는다면 상승
     

     
## 3단계
* 90도 회전, 전진, 45도 회전한다.<br>
* 2단계 알고리즘을 이용해 중앙점을 찾는다. <br>
* 찾은 뒤 Yow(각도)를 조절한다. <br>
```matlab
     image = snapshot(cameraObj);

        image1R = image(:,:,1);
        image1G = image(:,:,2);
        image1B = image(:,:,3);

        image_only_B = image1B-image1R/2-image1G/2;
        bw = image_only_B > 55;
        bw_origin = bw;


        stats = regionprops(bw);
        centerIdx=1;

        if(~isempty(stats))
            for i = 1:numel(stats)
                if stats(i).Area>stats(centerIdx).Area
                    centerIdx=i;
                end
            end
            rectangle('Position', stats(centerIdx).BoundingBox, ...
                'Linewidth', 3, 'EdgeColor', 'b', 'LineStyle', '--');
            hold on;

            bw(stats(centerIdx).BoundingBox(2):stats(centerIdx).BoundingBox(2)+stats(centerIdx).BoundingBox(4),stats(centerIdx).BoundingBox(1):stats(centerIdx).BoundingBox(1)+stats(centerIdx).BoundingBox(3))=1;
        end

        [row_bounding, col_bounding] = find(bw);

        cf_B=mean(col_bounding);

        bw_origin1 = imfill(bw_origin,"holes");

        [row_origin, col_origin] = find(bw_origin1);

        cf_O=mean(col_origin);

        correcting_cf = cf_B - cf_O;
        disp('correcting_cf');
        disp(correcting_cf);

        if correcting_cf > 0
            disp("turn left");

            turn(droneobj, deg2rad(-10));
            disp(correcting_cf);

            Center_restart = 1;

        
        elseif correcting_cf < 0
            disp("turn right");

            turn(droneobj, deg2rad(10));
            disp(correcting_cf);

            Center_restart = 1;
        else
            Center_restart = 1;
        end
```
     
: 화면에 보이는 파란 부분의 무게중심을 찾고, 무게중심과 중앙점이 어떻게 위치해있는지에 따라 각도 조절

* 다시 2단계 알고리즘으로 중앙점 찾고 통과한다.










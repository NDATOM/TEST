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
<br>
<br>

**대회 맵 구성과 비슷한 환경을 만들어 연습**<br>
![KakaoTalk_20220711_113637715](https://user-images.githubusercontent.com/103032180/178187069-9ce6c275-917b-4d44-9b45-9b5c5327a93e.jpg)



# 알고리즘 설명 및 소스코드 설명
~하강반복문 알고리즘, 직진반복문 알고리즘~

# n. BoundingBox 알고리즘, 중심 찾기 알고리즘

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

맞나??
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
드론 이미지에서, 파란색 성분만을 검출
반전시킨 뒤, imerode 함수로 침식시킨다.
mean 함수로 중심값을 찾는다.


# n. 하강반복문 알고리즘???



# n. 전체 단계 통과 알고리즘

## 1단계
빨간색의 h, s, v 값, regionprops로 빨간색 표식의 속성을 찾는다.
드론이 보는 표식의 크기가 5500이상, 즉 가까운 경우에는 moveforward로 직진하도록 하고
먼 경우에는 더 많이 직진하도록 한다.


## 2단계
4가지 경우를 반복한다. 

##### 첫 번째: 화면에 링의 파란 부분이 꽉 찼을 때 중앙점을 찾고 통과
원과 원의 중심을 검출해내고, 원의 중심과의 차이에 따라 중심으로 이동

##### 두 번째: 화면에 링의 파란 부분이 꽉 차지 않았을 때 중앙점을 찾고 통과
원과 원의 중심을 검출해내고, 원의 중심과의 차이에 따라 중심으로 이동

##### 세 번째: 화면에 링의 파란 부분이 존재하지 않음
드론이 더 상승하여 첫 번째나 두 번째 경우가 되도록 함

##### 네 번째: 화면에 링의 파란 부분이 꽉 찼음
전체화면의 중심과 원의 중심과의 차이에 따라 원의 중심으로 이동


## 3단계
* 90도 회전, 전진, 45도 회전한다.<br>
* 2단계 알고리즘을 이용해 중앙점을 찾는다. <br>
* 찾은 뒤 Yow(각도)를 조절한다. <br>
: 화면에 보이는 파란 부분의 무게중심을 찾고, 무게중심과 중앙점이 어떻게 위치해있는지에 따라 각도 조절

* 다시 2단계 알고리즘으로 중앙점 찾고 통과한다.




# 소스 코드 설명






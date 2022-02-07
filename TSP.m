%%旅行商问题的模拟退火算法实现
clear;
clc;
%%
%map = xlsread('邻接矩阵.xlsx');
map = [
    0	2	2	1	3
    2	0	3	2	3
    2	3	0	6	3
    1	2	6	0	5
    3	3	3	5	0];
[nodeNum,~] = size(map);
map(find(map == -1)) = inf;
times = 200;    %迭代次数
T0 = 100;   % 初始温度
T = T0; % 迭代中温度会发生改变，第一次迭代时温度就是T0
maxgen = 200;  % 最大迭代次数
Lk = 200*nodeNum;  % 每个温度下的迭代次数
alfa = 0.95;  % 温度衰减系数

%%
%生成初始解
way0 = randperm(nodeNum);        
dist0 = CountDist(map,way0,nodeNum);

minDist = dist0;
minWay = way0;
%%
%迭代退火
for t=1:times
    for i=1:Lk
        %生成新解
        node1 = randi(nodeNum);
        node2 = randi(nodeNum);
        while node2~=node1
            node2 = randi(nodeNum);
        end
        
        way1 = way0;
        tempNodenode = way1(node1);
        way1(node1) = way1(node2);
        way1(node2) = tempNodenode;
        
        dist1 = CountDist(map,way1,nodeNum);
        %选择结果
        if dist1 <= dist0
            dist0 = dist1;
            way0 = way1;
            
            if dist0 < minDist
                minDist = dist0;
                minWay = way0;
            end       
        else
            if rand(1) < exp( (dist1-dist0)/T )
                dist0 = dist1;
                way0 = way1;
            end           
        end      
    end
    T = T*alfa;
end
%%验证算法
Bway = 1:nodeNum;
Bdist = inf;
allWays = perms(1:nodeNum);
[wayNum,~] = size(allWays);
for i=1:wayNum
    td = CountDist(map,allWays(i,:),nodeNum);
    if td < Bdist
         Bdist = td;
         Bway = allWays(i,:);
    end
end

%%
%输出结果
disp("MinDist:"+Bdist);
disp("MinWay:");
for i=1:nodeNum
    disp(Bway(i)+"->")
end
disp("********************************");
disp("SAMinDist:"+minDist);
disp("SAMinWay:");
for i=1:nodeNum
    disp(minWay(i)+"->")
end
%%
%计算路径长
function dist = CountDist(map,way,nodeNum)
    dist = 0;
    for i=1:nodeNum-1
        dist = dist+ map(way(i),way(i+1));      
    end
    dist = dist+ map(way(nodeNum),way(1));      
end
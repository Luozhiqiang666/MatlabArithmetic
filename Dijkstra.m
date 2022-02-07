function [min_dist,path] =  Dijkstra(map,startNode,endNode)
%map:节点的关系矩阵
%%
    %s数据定义
        [nodeNum,~] = size(map);
        flag = zeros(1,nodeNum);    %flag储存是否便利，初始值为0
        %flag[startNode] = 1;        %起始节点标记为已遍历

        inNode = zeros(1,nodeNum);  %储存上一个节点
        inNode(startNode) = startNode;

        dist = ones(1,nodeNum)*inf; %储存当前距离
        dist(startNode) = 0;    %起始节点到起始节点的距离为0
    %%
    %算法实现
    selectedNode = 0;

    for i=1:nodeNum     %便利nodeNum次
        %选出未标记的距离最小的节点
        selectedDist = inf;
        for p = 1:nodeNum
            %寻找下一个节点
            if (dist(p) < selectedDist)&&( flag(p) == 0 )
                selectedNode = p;
                selectedDist = dist(p);
            end
        end
        flag(selectedNode) = 1;
            %加入下一个节点
        for j = 1:nodeNum
            if selectedDist+map(selectedNode,nj) < dist(j)
                dist(j) = selectedDist+map(selectedNode,j);
                inNode(j) = selectedNode;
            end
        end

    end
%%
    %返回结果
    path = endNode;
    min_dist = dist(endNode);
    thisNode = inNode(endNode);
    while thisNode ~= startNode
        path = [thisNode,path];
        thisNode = inNode(thisNode);
    end
    path = [startNode,path];

end
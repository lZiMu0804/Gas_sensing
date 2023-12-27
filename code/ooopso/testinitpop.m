function pop = testinitpop(D,maxnum,limit)
i=1;
while i<maxnum+1
    for j=1:D
        pop(j,i) = roundn(limit(j, 1) + (limit(j, 2) - limit(j, 1)) * rand(1,1),-1);%The position of the initial population ,x is a matrix with D rows and N columns
%     end
%     if islegal(pop(:,i))
%         i=i+1;
    end
            i=i+1;

end
end






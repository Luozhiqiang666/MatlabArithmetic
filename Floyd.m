function dist=Floyd(a,sb,db)
n=size(a,1);
path=zeros(n);
 
for i=1:n
  for j=1:n
    if a(i,j)~=inf  
      path(i,j)=j; 
    end
  end
end


for k=1:n
  for i=1:n
    for j=1:n
      if a(i,j)>a(i,k)+a(k,j)
         a(i,j)=a(i,k)+a(k,j);
          path(i,j)=path(i,k);
      end
    end
  end
end
 dist=a(sb,db);
 mypath=sb;
 t=sb;
while t~=db 
  temp=path(t,db);
  mypath=[mypath,temp];  
  t=temp;
end
return
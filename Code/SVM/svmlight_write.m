function svmlight_write(targets,features,filename)
%svmlight_write(targets,features,filename)
%
%Description: This function takes a vector of classification 
%targets, a matrix of feature values, and a file name and
%write the targets and features to the specified file in
%svmlight format.
%
%targets: A length N vector of class labels. Class labels mut
%         be integers between 1 and C where C is the number of
%         classes.
%features: A matrix of size NxD containing D feature values for 
%          each data case
%filename: Name of file to write to

[N,D]=size(features);
fid=fopen(filename,'W');
for n=1:N
  n
  fprintf(fid,'%d', targets(n));
  for d=1:D
    if(abs(features(n,d))>1e-3)
      fprintf(fid,' %d:%f',d,features(n,d));
    end
  end
  fprintf(fid,'\n');
end
fclose(fid);


  

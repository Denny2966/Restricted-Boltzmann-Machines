%This simple demo creates a matrix containing one image per row
%stored in row-major format and displays that image using the
%provided make_grid_image() function. See make_grid_image()
%for more details on arguments and outputs.

%Make a 28x28 image
X = zeros(28,28);
X(:) = (1:(28*28))/784;

%Convert to a 28*28=784-long row-major format vector
Y=X';
Y=Y(:)';

%Create 25 copies of the image in row-major format
Y = repmat(Y,[25,1]);

%Scale the brightness to make 25 different images
Y = diag((1:25)/25)*Y;

%Make a grid image from the 25x784 matrix of images
GridImg = make_grid_image(Y,28,28,5,5,0.5);

%Plot the single image and the 25 images GridImg
figure(1)
subplot(1,2,1)
imagesc(X);
axis square;
axis off;

subplot(1,2,2)
imagesc(GridImg);
axis square;
axis off;

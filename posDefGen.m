%Generate random positive definite
%matrices, and use them to test that logdet is
%concave for lines in positive definite space

%Generate random matrix and make a random
%symmtric positive definite matrix from it
randomMatrix = rand(3,3);
randomPosDef = randomMatrix'*randomMatrix;

%t is a parameter of the line in positive def space
t=[1:100];

%V is a matrix that defines the direction of the line
%in positive definite space (note that V need not be 
%positive definite, just symmetric)
randomMatrix2=rand(3,3);
V = randomMatrix2'*randomMatrix2;

%Evaluate and plot the line: g(t) = log(det(X + tV)
%where X is the random positive definit matrix
for i = 1:100
gt(i) = log(det(ata + V.*t(i)));
plot(gt);
end
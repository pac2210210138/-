filename = 'data2.xls';
PXY = xlsread(filename);
PX = sum(PXY, 2); 
PY = sum(PXY, 1);
HX = -sum(PX(PX > 0) .* log2(PX(PX > 0)));
HY = -sum(PY(PY > 0) .* log2(PY(PY > 0)));
HXY = -sum(PXY(PXY > 0) .* log2(PXY(PXY > 0)), 'all');
HY_given_X = 0;
for i = 1:size(PXY, 1)
    for j = 1:size(PXY, 2)
        if PXY(i, j) > 0
            HY_given_X = HY_given_X - PXY(i, j) * log2(PXY(i, j) / PX(i));
        end
    end
end
HX_given_Y = 0;
for i = 1:size(PXY, 1)
    for j = 1:size(PXY, 2)
        if PXY(i, j) > 0
            HX_given_Y = HX_given_Y - PXY(i, j) * log2(PXY(i, j) / PY(j));
        end
    end
end
IXY = HX - HX_given_Y;
fprintf('H(X) = %.4f bits\n', HX);
fprintf('H(Y) = %.4f bits\n', HY);
fprintf('H(X,Y) = %.4f bits\n', HXY);
fprintf('H(Y|X) = %.4f bits\n', HY_given_X);
fprintf('H(X|Y) = %.4f bits\n', HX_given_Y);
fprintf('I(X;Y) = %.4f bits\n', IXY);

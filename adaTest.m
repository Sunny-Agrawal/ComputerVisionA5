function match = adaTest(cascade, integral)

match = 0;
thresh = 0;
val = 0;
for layer = 1 : size(cascade, 1)
    harFeat = cascade(layer, 1:5);
    f = harInterp(integral, harFeat);
    t = cascade(layer, 6);
    h = f < t;
    alpha = cascade(layer, 7);
    val = val + h * alpha;
    thresh = thresh + alpha;
end

thresh = thresh / 2;

if val >= thresh
    match = 1;
end
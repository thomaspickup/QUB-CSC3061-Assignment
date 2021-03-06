clear all
close all

%% Training
addpath('functions/SVM-KM');
addpath('images');
addpath('functions');
addpath('dataset');
sampling=1;
kValue = [1, 3, 5, 10];
[trainImages,trainLabels,testImages,testLabels] = loadImages(0,sampling);
trainGabor = getGabor(trainImages);
NNmodel = KNNTraining(trainGabor, trainLabels);
fprintf('Training done\n');

%% Testing
testGabor = getGabor(testImages);
numberOfImages = size(testGabor,1);
results = zeros(numberOfImages,1);

for k = 1:numel(kValue)
    results = zeros(numberOfImages,1);

    for i=1:numberOfImages
        results(i) = KNNTesting(testGabor(i,:), NNmodel, kValue(k));
    end

    fprintf('KNN with k=%d\n',kValue(k));
    
    getConfusionMatrix(testLabels, results);
end

save gabor_KNN NNmodel 
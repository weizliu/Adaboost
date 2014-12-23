Adaboost
========

This is a simple implementation of Adaboost used in face detection but without cascade step. 
4000 negative training samples and 2600 positive training samples.
4000 negative test samples and 2600 positive test samples.
Error rate over training dataset is about 0.02, over test dataset is about 0.03.


train.m  
-----------
It will train an adaboost classifier.

loadDataset.m
-----------
Upload dataset.

integralImage.m
-----------
Computer intergral images.

adaBoost.m
-----------
The detail of implementation of adaboost classifier.

generateFilters.m
-----------
Generate Harr-like filters.

filterResponse.m 
-----------
Compute response of filters.

weakClassifier.m
-----------
Compute output of a weak classifier.

evaluateClassifier.m
-----------
Compute output of adaboost classifier.

evaluateSliding.m
-----------
Sliding window over a test image and judge whether a window contains face.

faces-data:
-----------
Dataset contains non-faces images and faces images.

H_8000_40_l.mat
-----------
A classifier trained with 4000 negative samples and 2600 positive samples and 40 iterations.

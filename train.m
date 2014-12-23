% TRAIN This script will setup the training environment, learner, then train.

clear
clc
T = 100;     % maximum number of weak classifiers to learn
N = 3000;   % number to load per class

tr_e_T = zeros(T,1); %recorder training sample error when T changes from 1 to 20
te_e_T = zeros(T,1);

[X,Y] = loadDataset(N);  % assume we get all pos and then all neg
n = length(Y);

for t = 1 : T %you can change it for T : T 
x = X(:,:,1:2:end);  %half data for training
y = Y(1:2:end);
y(find(y == 0)) = -1; % label is 1 or -1

f = generateFilters(size(x,1),size(x,2),[size(x,1)/2,size(x,1)/2,size(x,2)/2,size(x,2)/2]);
H = adaBoost(x,y,f,t);

% compute empirical training error
y_ = evaluateClassifier(H,x) %y_ is 1 or -1
y(find(y == 0)) = -1;  %label is 1 or -1
tr_e = sum(y_~=y')/length(y);
fprintf('Empirical Training Error Rate: %.2f\n',tr_e);
tr_e_T(t) = tr_e;

%compute empirical testing error
x = X(:,:,2:2:end);
y = Y(2:2:end);
y_ = evaluateClassifier(H,x)
y(find(y == 0)) = -1;
te_e = sum(y_~=y')/length(y);
fprintf('Empirical Testing Error Rate: %.2f\n',te_e);
te_e_T(t) = te_e;
end
save H;

%plot error
plot(1:T,tr_e_T,'-bo');
hold on
plot(1:T,te_e_T,'-ro');
xlabel('T');
ylabel('error');
legend('training sample error','test sample error');


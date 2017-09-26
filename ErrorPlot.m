% newData = data(:,3) - ones(4000)*1;%%26.2;
% plot(data(:,1),newData)

Measured = [40,35,32,27,26,31];
Actual = [38,33,31,27,25,30];
Error = Measured - Actual
plot([20,50],[0,0])
hold on
scatter(Actual, Error)
axis([20 50 -10 10])
xlabel('Actual Distance') % x-axis label
ylabel('Error') % y-axis label
legend('Ideal State','Errors')
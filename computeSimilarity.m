% computes the similarity between two distributions using bhattacharyas
% coefficients
function [similarity] = computeSimilarity(q , p , numBins)

rho = 0;
for i = 1:numBins
    rho = rho + sqrt(p(1,i) * q(1,i));
end

similarity = sqrt (1-rho);
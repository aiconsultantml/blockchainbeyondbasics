--------------------------------------------------------------------------------
-- The following query gets the Token contract addresses
-- shows the data by the Wallet address count and transactions count
SELECT
  DISTINCT contract_address,
  COUNT(DISTINCT wallet_address) AS addr_count,
  COUNT(DISTINCT id) AS session_count
FROM `bigquery-public-data.crypto_ethereum.sessions`
GROUP BY  contract_address
ORDER BY 2 DESC
LIMIT 10000;

--------------------------------------------------------------------------------
-- The following query creates an unsupervised KNN model to classify Tokens on Ethereum Platform - 
Running the following query will create a model.
 
CREATE OR REPLACE MODEL  ml.token_knncluster 
OPTIONS(model_type='kmeans', num_clusters=5) AS
SELECT
  addr_count
FROM (
  SELECT
    DISTINCT contract_address,
    COUNT(DISTINCT wallet_address) AS addr_count
  FROM `bigquery-public-data.crypto_ethereum.sessions`
  GROUP BY contract_address
  ORDER BY 2 DESC
  LIMIT 10000 );
 
--------------------------------------------------------------------------------
-- The following query creates a Table on the predictions by Model model to classify Tokens on Ethereum Platform 
 
CREATE OR REPLACE TABLE ml.predictions AS
SELECT
  * EXCEPT(nearest_centroids_distance)
FROM ML.PREDICT(MODEL ml.token_knncluster,
    (
    SELECT
      DISTINCT contract_address,
      COUNT(DISTINCT wallet_address) AS addr_count
    FROM `bigquery-public-data.crypto_ethereum.sessions`
    GROUP BY contract_address
    ORDER BY 2 DESC
    LIMIT 10000)) ;
 
--------------------------------------------------------------------------------
-- The following query gets a quick summary on how the dat looks like 
SELECT
  CENTROID_ID,
  ROUND(AVG(addr_count)) average,
  MIN(addr_count) AS minimum,
  MAX(addr_count) AS maximum,
  COUNT(*)
FROM ml.predictions
GROUP BY CENTROID_ID;
 
--------------------------------------------------------------------------------
--Let's Create a visualization using the following query
SELECT *
FROM  ml.predictions;
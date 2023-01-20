SELECT * 
FROM tech_funding_2020
ORDER BY funding_amount_usd DESC;


-- Total Tech Fundings in 2020
SELECT FORMAT(SUM(funding_amount_usd),0) Total_funding 
FROM tech_funding_2020;
-- 205,259,462,802 USD


-- How much funding did each industries receive? 
SELECT ROW_NUMBER () OVER (ORDER BY SUM(funding_amount_usd) DESC) AS S_N, 
	   vertical AS Industries, 
	   FORMAT (SUM(funding_amount_usd),0) Total_funding   
FROM tech_funding_2020
GROUP BY Industries;

-- Which region received the highest funding?
SELECT SUM(funding_amount_usd) total_funding, region
FROM tech_funding_2020 
GROUP BY region
ORDER BY total_funding DESC
LIMIT 1;
-- Answer: United States (117,549,449,595 USD)

-- How many companies in the US region recieved funding?
SELECT  *,
		ROW_NUMBER () OVER (ORDER BY funding_amount_usd) S_N
		
FROM tech_funding_2020
WHERE region = 'United States';
-- Answer: 2027 Companies 
       

-- What are the top 5 industries that received the highest amount of funding?
SELECT ROW_NUMBER () OVER (ORDER BY SUM(funding_amount_usd) DESC) AS S_N, 
	    vertical AS Industries,
        FORMAT(SUM(funding_amount_usd),0) Total_funding
FROM tech_funding_2020
GROUP BY Industries
LIMIT 5;
-- Answer: FinTech, B2B Software, Transportation, Cloud Computing, Artificial Intelligence,

-- What are the bottom 5 industries that received the lowest amount of funding?
SELECT ROW_NUMBER () OVER (ORDER BY SUM(funding_amount_usd)) AS S_N,
	   vertical AS Industries,
       FORMAT(SUM(funding_amount_usd),0) Total_funding
FROM tech_funding_2020
GROUP BY Industries
LIMIT 5;
-- Answer: Venture Capital, Developer APIs, Fashion, Food & Beverage, Security

-- What is the total amount of funding given by funding type?
SELECT ROW_NUMBER () OVER (ORDER BY SUM(funding_amount_usd) DESC) AS S_N,
	   funding_type AS Funding_type,
	   FORMAT(SUM(funding_amount_usd),0) Total_funding
FROM tech_funding_2020
GROUP BY 2;
-- Note: Series C funding type had the highest amount of funding (42,281,396,805 USD)


-- How many AI companies received funding and how much did each of them recieve?
SELECT ROW_NUMBER () OVER (ORDER BY funding_amount_usd DESC) AS S_N,
	   company AS Company,
       vertical AS Industry,
       FORMAT(funding_amount_usd,0) AS Total_funding,
       funding_type
FROM tech_funding_2020
WHERE vertical = 'Artificial Intelligence';
-- Answer: 283 AI Companies received funding within the time period (Databricks received the highest amount of funding - 1,600,000,000 USD)

-- Which company received the highest funding?
SELECT *, FORMAT(funding_amount_usd,'$ 0') funding_amount
FROM tech_funding_2020
WHERE funding_amount_usd = (SELECT MAX(funding_amount_usd)
FROM tech_funding_2020);
-- Answer: WestConnex ( $16,600,000,000)

-- AI Comnpanies that recieved Seed funding
SELECT *, FORMAT (funding_amount_usd,0) funding_amount, ROW_NUMBER () OVER (ORDER BY funding_amount_usd DESC) S_N
FROM tech_funding_2020
WHERE vertical = 'Artificial Intelligence' AND funding_type = 'Seed'
ORDER BY funding_amount_usd DESC;
-- Answer: 70 AI Companies recieved Seed funding

-- How many Nigerian Companies recieved funding?
SELECT COUNT(*)
FROM tech_funding_2020
WHERE region = 'Nigeria';

-- 24 Companies

-- How much total funding did Nigerian companies recieve?
 SELECT FORMAT(SUM(funding_amount_usd),0) total_funding, region
 FROM tech_funding_2020
 WHERE region = 'Nigeria';
 
 -- Answer: $544,583,000 

-- Which Nigerian company recieved the most funding?
SELECT * , FORMAT(funding_amount_usd,0) formatted_amount
FROM tech_funding_2020
WHERE (region,funding_amount_usd) = (SELECT region,MAX(funding_amount_usd)
							FROM tech_funding_2020
                            WHERE region = 'Nigeria');

-- Answer: OPay (USD 400,000,000)


-- What was the highest funding amount recieved in each region and which companies recieved this funding?
SELECT *
FROM tech_funding_2020 t 
JOIN (SELECT region,
				   MAX(funding_amount_usd) highest_funding
			FROM tech_funding_2020
            GROUP BY region) t2
ON t.region = t2.region AND t.funding_amount_usd = t2.highest_funding
ORDER BY funding_amount_usd DESC;





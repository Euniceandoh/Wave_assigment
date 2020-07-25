QUESTION 1
SELECT COUNT(u_id)
FROM users;


QUESTION 2
SELECT COUNT(u_id)
FROM transfers
WHERE send_amount_currency ='cfa';

QUESTION 3
SELECT COUNT(DISTINCT u_id)
FROM transfers
WHERE send_amount_currency = 'cfa';


QUESTION 4
SELECT COUNT(*) atx_id,
DATE_PART('month', when_created) months_in_year_2018
FROM agent_transactions
WHERE when_created BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY 2
ORDER BY 2 ASC;


QUESTION 5
SELECT COUNT(agent_id)
FROM agent_transactions
WHERE (amount > 0 OR < 0)
GROUP BY when_created BETWEEN '2020-07-17' AND '2020-07-24';


QUESTION 6
SELECT City,
Volume INTO atx_volume_city_summary
FROM ( Select agents.city AS City, count(agent_transactions.atx_id) AS Volume
FROM agents
INNER JOIN agent_transactions ON agents.agent_id = agent_transactions.agent_id where (agent_transactions.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY agents.city) as atx_volume_summary;

QUESTION 7
SELECT City, Volume, Country INTO atx_volume_city_summary_with_Country
FROM ( Select agents.city AS City, agents.country AS Country,
COUNT(agent_transactions.atx_id) AS Volume
FROM agents INNER JOIN agent_transactions ON agents.agent_id = agent_transactions.agent_id
WHERE (agent_transactions.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY agents.country,agents.city) AS atx_volume_summary_with_Country;

QUESTION 8
SELECT transfers.kind AS Kind, wallets.ledger_location AS Country,
SUM (transfers.send_amount_scalar) AS Volume FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
WHERE(transfers.when_created > (NOW() - INTERVAL '1 week'))
GROUP BY wallets.ledger_location, transfers.kind;

QUESTION 9
 SELECT count(transfers.source_wallet_id) AS Unique_Senders, count(transfer_id) AS Transaction_count, transfers.kind AS Transfer_Kind, wallets.ledger_location AS Country,
 SUM(transfers.send_amount_scalar) AS Volume FROM transfers
 INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
 WHERE (transfers.when_created > (NOW() - INTERVAL '1 week'))
 GROUP BY wallets.ledger_location, transfers.kind;

 QUESTION 10
 SELECT source_wallet_id, send_amount_scalar
 FROM transfers
 WHERE send_amount_currency = 'CFA'
 AND (send_amount_scalar>10000000)
 AND (transfers.when_created > (NOW() - INTERVAL '1 month'));

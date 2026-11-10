
CREATE TABLE users (
	id UUID PRIMARY KEY,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT 
CURRENT_TIMESTAMP
);

CREATE TABLE trades (
	id UUID PRIMARY KEY,
	user_id UUID REFERENCES users(id),
	
	symbol VARCHAR(20) NOT NULL,
	direction VARCHAR(10) NOT NULL,
	
	entry_price DECIMAL(10,5),
	exit_price DECIMAL(10,2),
	
	risk DECIMAL(10,2),
	pnl DECIMAL(10,2),
	
	notes TEXT,
	
	created_at TIMESTAMP DEFAULT
CURRENT_TIMESTAMP
);

INSERT INTO users 
(id, email, password)
VALUES
(
	gen_random_uuid(),
	'test@test.com',
	'hashedpassword'
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT * FROM users;

INSERT INTO trades (
	id,
	user_id,
	symbol,
	direction,
	entry_price,
	exit_price,
	risk,
	pnl,
	notes
)
VALUES (
	gen_random_uuid(),
	'eea8065f-8e99-42cb-8243-3fe130dba63e',
	'USDJPY',
	'Long',
	145.50,
	146.20,
	100,
	140,
	'Foreign key test'
);

SELECT * FROM trades;

INSERT INTO trades (
	id,
	user_id,
	symbol,
	direction
)
VALUES (
gen_random_uuid(),
gen_random_uuid(),
'EURUSD',
'Short'
);

SELECT
	users.email,
	trades.symbol,
	trades.direction,
	trades.pnl
FROM trades
JOIN users 
ON trades.user_id = users.id;

SELECT * FROM users;
SELECT * FROM trades;

SELECT 
	users.email,
	trades.symbol,
	trades.pnl
FROM trades 
JOIN users
ON trades.user_id = users.id;
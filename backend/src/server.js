const pool = require("./db/db");   
const express = require('express');

const app = express();

app.use(express.json());

const PORT = 3000;



app.get("/api/test-db", async (req, res) => {   
    try {
        const result = await pool.query("SELECT NOW()"
        );

        res.json( result.rows[0]);
    }   catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Database connection failed"         
        });
    }
});

app.get("/api/users", async (req, res) => { 
    try {
        const result = await pool.query(
            "SELECT * FROM users"
        ); 

        res.json(result.rows);
    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Failed to fetch users"
        });
    }
});

app.get("/api/health", (req, res) => {
    res.json({
        status: "OK", 
        message: "Trading Journal API is running"
    });
});

app.use(express.json());    

app.post("/api/register", async (req, res) => {
    try {
        const { email, password } = req.body;

        const result = await pool.query(
            `
            INSERT INTO users (id, email, password) 
            VALUES (
            gen_random_uuid(),
            $1,
            $2
            )
            RETURNING *
            `,
            [email, password]
        );

        res.status(201).json(result.rows[0]);
    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Registration Failed"
        });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});


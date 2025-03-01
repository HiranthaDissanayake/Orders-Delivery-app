const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

app.listen(5000, () => {
    console.log("Server is running on port 5000");
})


// Database connection
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "1234",
    database: "red_dress_db",
});

db.connect((err)=>{
    if(err){
        console.log(err);
    }
        console.log("Connected to database");
});


// APi for Login 
app.post("/api/login", (req, res)=>{
    const {email, password} = req.body;

    if(!email || !password){
        return res.status(400).json({
            message: "Email and password are required",
        });
    }



    const sql = "SELECT * FROM delivers WHERE email = ? AND password = ?";


    db.query(sql, [email, password], (err, results)=>{
        if(err){
            return res.status(500).json({
                message: "Database error",
            });
        }

        if(results.length > 0){

            //User found
            return res.status(200).json({
                message: "Login successful",
                user: results[0].email,
            });
        }else{

            //User not found
            return res.status(401).json({
                message: "Invalid email or password",
            });
        }
    })
});


// Api for get orders from database

app.get("/api/orders", (req, res)=>{
    const sql = "SELECT * FROM orders";
    db.query(sql, (err, results)=>{
        if(err){
        return res.status(500).json({
            message: "Database error",
        });
        }
        return res.status(200).json(results);
                
    })
});


// Api for delete order from database

app.delete("/api/orders/:id", (req, res)=>{
    const id = req.params.id;
    const sql = "DELETE FROM orders WHERE id = ?";
    db.query(sql, [id], (err, results)=>{
        if(err){
            return res.status(500).json({
                message: "Database error",
            });
        }
        return res.status(200).json({
            message: "Order deleted successfully",
        });
    });
});

// Api for add delivered order to delivered table

app.post("/api/delivered", (req, res)=>{
    const {id, customerName, phone, address } = req.body;
    const sql = "INSERT INTO deliveredorders (id, customerName, phone, address) VALUES (?, ?, ?, ?)";
    db.query(sql, [id, customerName, phone, address], (err, results)=>{
        if(err){
            return res.status(500).json({
                message: "Database error",
            });
        }
        return res.status(200).json({
            message: "Order added to delivered table",
        });
    });
});


// Api for get delivered orders from database
app.get("/api/deliveredOrders", (req, res)=>{
    const sql = "SELECT * FROM deliveredorders";
    db.query(sql, (err, results)=>{
        if(err){
        return res.status(500).json({
            message: "Database error",
        });
        }
        return res.status(200).json(results);
                
    })
});





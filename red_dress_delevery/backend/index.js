const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

app.listen(5001, () => {
    console.log("Server is running on port 5001");
})

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




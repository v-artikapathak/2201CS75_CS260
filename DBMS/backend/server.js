const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')
require('dotenv').config()
const {signupUser,loginUser} = require('./controller/UserController');

const app = express()
app.use(express.json());
app.use(cors());
app.post('/api/user/signup', signupUser);
app.post('/api/user/login', loginUser);

mongoose.connect('mongodb+srv://kanahia:amongodb123@democluster.36mj3o1.mongodb.net/?retryWrites=true&w=majority&appName=DemoCluster')
    .then(() => {   
        app.listen(5000, () => {
            console.log('Server started');
        });
    }
    )
    .catch(() => {
        console.log('Connection failed');
    }
    );

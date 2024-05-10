const User = require('../models/UserModel');
const jwt = require('jsonwebtoken');

const createToken = (_id) => {
    return jwt.sign ({_id}, process.env.SECRET, { expiresIn: '100d' });
}

const loginUser = async (req, res) => {
    const {email, password} = req.body;
    try {
        const user = await User.login(email, password);
        const token = createToken(user._id);

        res.status(200).json({email, token});
    } catch (err) {
        res.status(400).json({mssg: err.message});
    }

}

const signupUser = async (req, res) => {
    const {email, password} = req.body;
    try {
        const user = await User.signup(email, password);
        const token = createToken(user._id);

        res.status(200).json({email, token});
    } catch (err) {
        res.status(400).json({mssg: err.message});
    }
}

module.exports = {signupUser, loginUser};

const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');
const validator = require('validator');

const userSchema = new Schema({
    email: {type: String, required: true, unique: true},
    password: {type: String, required: true}
});

userSchema.statics.signup = async function(email, password) {
    
    if (!email || !password) {
        throw new Error('Email and password are required');
    }

    if (!validator.isEmail(email)) {
        throw new Error('Email is invalid');
    }

    const exists = await this.findOne({email});
    
    if (exists) {
        throw new Error('User already exists');
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);
    const user = new this({email, password: hashedPassword});

    return user.save();
}

userSchema.statics.login = async function(email, password) {
    if (!email || !password) {
        throw new Error('Email and password are required');
    }

    const user = await this.findOne({email});

    if (!user) {
        throw new Error('User does not exist');
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
        throw new Error('Invalid password');
    }

    return user;
}


module.exports = mongoose.model('User', userSchema);
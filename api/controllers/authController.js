const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

const generateToken = (user) => {
    return jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });
}

export const register = async (req, res) => {
    const { username, password } = req.body;
    const hashed = await bcrypt.hash(password, 8); // Hash the password to store it securely
    // TODO - Check if username already exists in database
    // TODO - Check if user already exists in database
    const user = { id: Date.now(), username, password: hashed }; // Create a new user with a unique ID
    //TODO - user.push(user); Save user to database
    res.status(201).json({ message: 'User successfully registered' });
}

export const login = async (req, res) => {
    const { username, password } = req.body;
    // TODO - const user = ... obtain user from database
    if (!user || !(await bcrypt.compare(password, user.password))) { // Compare the provided password with the hashed password in the database
        return res.status(401).json({ message: 'Invalid credentials' });
    }
    const token = generateToken(user); // Generate a JWT token for the user
    res.status(200).json({ token });
}

export const profile = async (req, res) => {
    //TODO - const user = users.find(user => user.id === req.user.id); Find user in database
    if (!user) {
        return res.status(404).json({ message: 'User not found'});
    }
    // Remove password from user object before sending response
    const { password, ...userWithoutPassword } = user;
    res.status(200).json({ userWithoutPassword });
}
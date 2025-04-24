const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const db = require('../../teste/database.js') // TODO - Replace with actual database connection
const validator = require('validator');

const generateToken = (user) => {
    return jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });
}

const register = async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }  

    // Validate email format
    if (!validator.isEmail(email)) {
        return res.status(400).json({ message: 'Invalid email format' });
    }

    try {
        // Check if the user already exists in the database
        const userExists = await new Promise((resolve, reject) => {
            const sql = 'SELECT * FROM tbl_users WHERE email = ?';
            db.get(sql, [email], (err, row) => {
                if (err) return reject(err);
                resolve(row);
            });
        });

        if (userExists) {
            return res.status(409).json({ message: 'Email already registered' });
        }
        
        // Validate password strength
        if (!validator.isStrongPassword(password, {
            minLength: 8,
            minLowercase: 1,
            minUppercase: 1,
            minNumbers: 1,
            minSymbols: 1,
        })) 
        {
            return res.status(400).json({
                message: 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one number, and one special character.',
            });
        }
        // Hash the password to store it securely
        const hashed = await bcrypt.hash(password, 8);

        // Store the user in the database
        await new Promise((resolve, reject) => {
            const sql = 'INSERT INTO tbl_users (email, password) VALUES (?, ?)';
            db.run(sql, [email, hashed], function(err) {
                if (err) return reject(err);
                resolve();
            });
        });

        res.status(201).json({ message: 'User successfully registered' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Database error' });
    }
}

const login = async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }

    try {
        const user = await new Promise((resolve, reject) => {
            const sql = 'SELECT * FROM tbl_users WHERE email = ?';
            db.get(sql, [email], (err, row) => {
                if (err) return reject(err);
                resolve(row);
            });
        });

        if (!user || !(await bcrypt.compare(password, user.password))) { // Compare the provided password with the hashed password in the database
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        
        const token = generateToken(user); // Generate a JWT token for the user
        res.status(200).json({ token });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Database error' });
    }
}

const profile = async (req, res) => {
    const id = req.user.id;

    try {
        // Fetch the user from the database using the ID from the JWT token
        const user = await new Promise((resolve, reject) => {
            const sql = 'SELECT * FROM tbl_users WHERE id = ?';
            db.get(sql, [id], (err, user) => {
                if (err) return reject(err);
                resolve(user);
            });
        });


        if (!user) {
            return res.status(404).json({ message: 'User not found'});
        }
        // Remove password from user object before sending response
        const { password, ...userWithoutPassword } = user;
        res.status(200).json({ userWithoutPassword });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Database error' });
    }
}

const test = async (req, res) => {
    try {
        const sql = 'SELECT * FROM tbl_users';
        const rows = await new Promise((resolve, reject) => {
            db.all(sql, [], (err, rows) => {
                if (err) return reject(err);
                resolve(rows);
            });
        });

        res.status(200).json({ rows });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Database error' });
    }
};

module.exports = {
    register,
    login,
    profile,
    test
};

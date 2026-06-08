const express = require('express');
const mysql = require('mysql2');
const multer = require('multer');
const session = require('express-session');
const cors = require('cors');
const path = require('path');
const fs = require('fs');

const app = express();

// Ensure uploads folder exists
if (!fs.existsSync('./uploads')) fs.mkdirSync('./uploads');

// Middleware
app.use(cors({ origin: '*' }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use(session({ secret: 'workapply_secret', resave: false, saveUninitialized: false }));

// MySQL connection
const db = mysql.createConnection({
    host: process.env.MYSQLHOST || 'localhost',
    user: process.env.MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || 'root',
    database: process.env.MYSQLDATABASE || 'railway',
    port: parseInt(process.env.MYSQLPORT) || 3306
});

db.connect(err => {
    if (err) { console.error('DB connection failed:', err.message); return; }
    console.log('Connected to MySQL database.');
});

// File upload config
const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, './uploads/'),
    filename: (req, file, cb) => cb(null, Date.now() + '_' + file.originalname)
});
const upload = multer({ storage, limits: { fileSize: 5 * 1024 * 1024 } });

// ─── USER ROUTES ───────────────────────────────────────────────

// Register
app.post('/register', (req, res) => {
    const { username, email, password } = req.body;
    db.query('INSERT INTO users (username, email, password) VALUES (?, ?, ?)',
        [username, email, password],
        (err) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            res.json({ success: true });
        });
});

// Login
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    db.query('SELECT * FROM users WHERE email = ? AND password = ?',
        [email, password],
        (err, results) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            if (results.length > 0) {
                req.session.username = results[0].username;
                req.session.email = email;
                res.json({ success: true, username: results[0].username });
            } else {
                res.json({ success: false, message: 'Invalid email or password.' });
            }
        });
});

// Logout
app.post('/logout', (req, res) => {
    req.session.destroy();
    res.json({ success: true });
});

// ─── APPLICATION ROUTES ────────────────────────────────────────

// Apply Job
app.post('/applyJob', upload.single('resume'), (req, res) => {
    const { name, email, skills, role, experience } = req.body;
    const resume = req.file ? req.file.filename : '';
    db.query('INSERT INTO job_applications (name, email, skills, role, experience, resume) VALUES (?, ?, ?, ?, ?, ?)',
        [name, email, skills, role, experience, resume],
        (err) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            res.json({ success: true });
        });
});

// Apply Internship
app.post('/applyInternship', upload.single('resume'), (req, res) => {
    const { name, email, skills, Role } = req.body;
    const resume = req.file ? req.file.filename : '';
    db.query('INSERT INTO internship_applications (name, email, skills, role, resume) VALUES (?, ?, ?, ?, ?)',
        [name, email, skills, Role, resume],
        (err) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            res.json({ success: true });
        });
});

// Apply Freelancing
app.post('/applyFreelancing', upload.single('resume'), (req, res) => {
    const { name, email, skills, role, experience } = req.body;
    const resume = req.file ? req.file.filename : '';
    db.query('INSERT INTO freelance_applications (name, email, skills, role, experience, resume) VALUES (?, ?, ?, ?, ?, ?)',
        [name, email, skills, role, experience, resume],
        (err) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            res.json({ success: true });
        });
});

// ─── CLIENT ROUTES ─────────────────────────────────────────────

// Client Register
app.post('/clientRegister', (req, res) => {
    const { username, email, password } = req.body;
    db.query('INSERT INTO clients (username, email, password) VALUES (?, ?, ?)',
        [username, email, password],
        (err) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            res.json({ success: true });
        });
});

// Client Login
app.post('/clientLogin', (req, res) => {
    const { email, password } = req.body;
    db.query('SELECT * FROM clients WHERE email = ? AND password = ?',
        [email, password],
        (err, results) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            if (results.length > 0) {
                req.session.clientEmail = email;
                res.json({ success: true });
            } else {
                res.json({ success: false, message: 'Invalid credentials.' });
            }
        });
});

// Client Dashboard - get all applications
app.get('/dashboard', (req, res) => {
    if (!req.session.clientEmail) return res.status(401).json({ success: false, message: 'Not logged in.' });
    db.query('SELECT name, email, skills, role, experience, resume, "job" AS type FROM job_applications UNION ALL SELECT name, email, skills, role, NULL, resume, "internship" AS type FROM internship_applications UNION ALL SELECT name, email, skills, role, experience, resume, "freelancing" AS type FROM freelance_applications',
        (err, results) => {
            if (err) return res.status(500).json({ success: false, message: err.message });
            res.json({ success: true, data: results });
        });
});

// Client Signout
app.post('/signout', (req, res) => {
    req.session.destroy();
    res.json({ success: true });
});

app.listen(3000, () => console.log('Server running at http://localhost:3000'));

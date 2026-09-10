// Experiment 01 - Sanitize Ghost export (remove private key, user passwords)
const fs = require('fs');
const path = require('path');

const inputFile = 'D:/oss-blog/scripts/wo-de-kai-yuan-bo-ke.ghost.2026-09-10-11-06-42.json';
const outputDir = 'D:/oss-blog/docs/backup';
const outputFile = path.join(outputDir, 'ghost-export-sanitized.json');

console.log('reading: ' + inputFile);
const raw = fs.readFileSync(inputFile, 'utf8');
const data = JSON.parse(raw);

const dbEntry = data.db[0];
const d = dbEntry.data;

// 1. Remove private keys from settings
if (d.settings) {
    const before = d.settings.length;
    const sensitiveKeys = ['private', 'ghost_private_key', 'members_private_key'];
    d.settings = d.settings.filter(s => !sensitiveKeys.includes(s.key));
    console.log('settings: ' + before + ' -> ' + d.settings.length + ' (removed private keys: ' + sensitiveKeys.join(', ') + ')');
}

// 2. Remove password from users
if (d.users) {
    for (const u of d.users) {
        if (u.password) {
            delete u.password;
            console.log('user ' + u.email + ': password hash removed');
        }
    }
}

// 3. Remove sensitive member data (keep email for demo, but remove geolocation if any)
if (d.members) {
    for (const m of d.members) {
        if (m.geolocation) {
            delete m.geolocation;
            console.log('member ' + m.email + ': geolocation removed');
        }
    }
}

// 4. Summary
console.log('--- export contents (sanitized) ---');
for (const key of Object.keys(d)) {
    if (Array.isArray(d[key])) {
        console.log('  ' + key + ': ' + d[key].length + ' items');
    }
}

// 5. Write sanitized output
fs.mkdirSync(outputDir, { recursive: true });
fs.writeFileSync(outputFile, JSON.stringify(data, null, 2), 'utf8');
const stat = fs.statSync(outputFile);
console.log('sanitized export written to: ' + outputFile + ' (' + stat.size + ' bytes)');
console.log('DONE');

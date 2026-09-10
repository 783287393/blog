// Experiment 01 - Read latest error log to debug comment 500
const fs = require('fs');
const path = require('path');
const logDir = 'D:/oss-blog/runtime/content/logs';
const errorLog = path.join(logDir, 'http___localhost_2368__development.error.log');

console.log('reading: ' + errorLog);
try {
    const content = fs.readFileSync(errorLog, 'utf8');
    const lines = content.split('\n');
    console.log('total lines: ' + lines.length);
    console.log('--- last 20 lines ---');
    for (let i = Math.max(0, lines.length - 20); i < lines.length; i++) {
        console.log((i + 1) + ': ' + lines[i].substring(0, 600));
    }
    console.log('--- lines containing comment/mail/error (last 10 matches) ---');
    const matches = [];
    for (let i = 0; i < lines.length; i++) {
        if (lines[i].toLowerCase().includes('comment') || lines[i].toLowerCase().includes('mail') || lines[i].toLowerCase().includes('error') || lines[i].toLowerCase().includes('stack')) {
            matches.push({ line: i + 1, text: lines[i].substring(0, 600) });
        }
    }
    for (const m of matches.slice(-10)) {
        console.log(m.line + ': ' + m.text);
    }
} catch (e) {
    console.log('ERROR: ' + e.message);
}

// Experiment 01 - Extract magic login links from Ghost logs
const fs = require('fs');
const path = require('path');
const logsDir = 'D:/oss-blog/runtime/content/logs';
console.log('scanning logs in: ' + logsDir);
try {
    const files = fs.readdirSync(logsDir).filter(f => f.endsWith('.log'));
    console.log('log files: ' + files.join(', '));
    let found = 0;
    for (const f of files) {
        const content = fs.readFileSync(path.join(logsDir, f), 'utf8');
        const lines = content.split('\n');
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            if (line.includes('token=') || (line.includes('portal') && line.includes('account')) || line.includes('magic')) {
                console.log('[' + f + ':' + (i + 1) + '] ' + line.substring(0, 400));
                found++;
            }
        }
    }
    if (found === 0) console.log('No magic links found yet. Request a sign-in link from the frontend first.');
} catch (e) { console.log('ERROR: ' + e.message); }

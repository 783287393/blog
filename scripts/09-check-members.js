// Experiment 01 - Check member details for comment debugging
const Database = require('better-sqlite3');
const db = new Database('D:/oss-blog/runtime/content/data/ghost-local.db', { readonly: true });

console.log('--- members (all fields) ---');
const members = db.prepare('select * from members').all();
for (const m of members) {
    console.log(JSON.stringify(m));
}

console.log('--- comments_enabled ---');
try {
    const s = db.prepare("select key, value from settings where key in ('comments_enabled','members_signup_access','portal_plans','email_verification')").all();
    for (const r of s) console.log(r.key + ' = ' + r.value);
} catch (e) { console.log('settings ERROR ' + e.message); }

console.log('--- comments table schema ---');
try {
    const cols = db.prepare("PRAGMA table_info(comments)").all();
    for (const c of cols) console.log(c.name + ' (' + c.type + ')');
} catch (e) { console.log('schema ERROR ' + e.message); }

db.close();

// Experiment 01 - Check current state (readonly)
const fs = require('fs');
const Database = require('better-sqlite3');
const db = new Database('D:/oss-blog/runtime/content/data/ghost-local.db', { readonly: true });

try {
    const s = db.prepare("select value from settings where key='active_theme'").get();
    console.log('active_theme = ' + (s ? s.value : 'NOT FOUND'));
} catch (e) { console.log('active_theme ERROR: ' + e.message); }

const tables = ['posts', 'tags', 'members', 'comments', 'users'];
for (const t of tables) {
    try {
        const r = db.prepare('select count(*) as c from ' + t).get();
        console.log(t + ': ' + r.c);
    } catch (e) { console.log(t + ': ERROR ' + e.message); }
}

console.log('--- published posts ---');
const rows = db.prepare("select slug, title from posts where status='published' and type='post' order by created_at").all();
for (const r of rows) console.log(r.slug + ' | ' + r.title);

console.log('--- tags ---');
const tags = db.prepare('select slug, name from tags').all();
for (const r of tags) console.log(r.slug + ' | ' + r.name);

console.log('--- members ---');
try {
    const m = db.prepare('select name, email, status from members').all();
    if (m.length === 0) console.log('(none)');
    for (const r of m) console.log(r.name + ' | ' + r.email + ' | ' + r.status);
} catch (e) { console.log('members ERROR ' + e.message); }

console.log('--- comments ---');
try {
    const c = db.prepare('select id, post_id, member_id, html, status from comments').all();
    if (c.length === 0) console.log('(none)');
    for (const r of c) console.log('id=' + r.id + ' post=' + r.post_id + ' member=' + r.member_id + ' status=' + r.status + ' html=' + (r.html || '').substring(0, 60));
} catch (e) { console.log('comments ERROR ' + e.message); }

db.close();

console.log('--- themes in content/themes ---');
const themesDir = 'D:/oss-blog/runtime/content/themes';
try {
    const dirs = fs.readdirSync(themesDir, { withFileTypes: true }).filter(d => d.isDirectory());
    for (const d of dirs) console.log(d.name);
} catch (e) { console.log('themes dir ERROR ' + e.message); }

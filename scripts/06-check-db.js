// Experiment 01 - Check Ghost database content (readonly)
// Run via 06-verify-content.ps1
const Database = require('better-sqlite3');
const db = new Database('D:/oss-blog/runtime/content/data/ghost-local.db', { readonly: true });

const tables = ['posts', 'tags', 'posts_tags', 'posts_authors', 'comments', 'members', 'users'];
for (const t of tables) {
    try {
        const r = db.prepare('select count(*) as c from ' + t).get();
        console.log(t + ': ' + r.c);
    } catch (e) {
        console.log(t + ': ERROR ' + e.message);
    }
}

console.log('--- published posts ---');
const rows = db.prepare("select status, type, slug, title from posts order by created_at").all();
for (const r of rows) {
    console.log(r.status + ' | ' + r.type + ' | ' + r.slug + ' | ' + r.title);
}

console.log('--- tags ---');
const tags = db.prepare('select name, slug from tags').all();
for (const r of tags) {
    console.log(r.slug + ' | ' + r.name);
}

console.log('--- comments_enabled setting ---');
try {
    const s = db.prepare("select value from settings where key='comments_enabled'").get();
    console.log('comments_enabled = ' + (s ? s.value : 'NOT FOUND'));
} catch (e) {
    console.log('settings query ERROR ' + e.message);
}

db.close();

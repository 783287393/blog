// Minimal test SMTP server for local Ghost development
// Listens on 127.0.0.1:1025, accepts all mail and discards it
const net = require('net');

const server = net.createServer((socket) => {
    socket.write('220 localhost Test SMTP\r\n');
    let dataMode = false;

    socket.on('data', (chunk) => {
        const lines = chunk.toString().split('\r\n');
        for (const line of lines) {
            if (!line) continue;
            const upper = line.toUpperCase();

            if (dataMode) {
                if (line === '.') {
                    dataMode = false;
                    socket.write('250 OK: queued\r\n');
                    console.log('[smtp] message accepted');
                }
                continue;
            }

            if (upper.startsWith('EHLO') || upper.startsWith('HELO')) {
                socket.write('250-localhost\r\n250 OK\r\n');
            } else if (upper.startsWith('MAIL FROM') || upper.startsWith('RCPT TO') ||
                upper.startsWith('RSET') || upper.startsWith('NOOP')) {
                socket.write('250 OK\r\n');
            } else if (upper.startsWith('DATA')) {
                dataMode = true;
                socket.write('354 End data with <CR><LF>.<CR><LF>\r\n');
            } else if (upper.startsWith('QUIT')) {
                socket.write('221 Bye\r\n');
                socket.end();
            } else {
                socket.write('250 OK\r\n');
            }
        }
    });

    socket.on('error', () => { });
});

server.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.log('Port 1025 already in use - another SMTP server is running (good).');
    } else {
        console.error('Server error:', err.message);
    }
});

server.listen(1025, '127.0.0.1', () => {
    console.log('Test SMTP server running on 127.0.0.1:1025');
    console.log('Keep this window open while using Ghost. Press Ctrl+C to stop.');
});

var https = require('follow-redirects').https;
const { data } = require('autoprefixer');
var fs = require('fs');

function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
}

var limit = randomIntFromInterval(1, 200);

var options = {
    method: 'GET',
    hostname: 'the-one-api.dev',
    path: `/v2/quote?limit=${limit}`,
    headers: {
        Authorization: `Bearer ${process.env.THE_ONE_API}`,
    },
    maxRedirects: 20,
};

var req = https.request(options, function (res) {
    var chunks = [];

    res.on('data', function (chunk) {
        chunks.push(chunk);
    });

    res.on('end', function (chunk) {
        var body = Buffer.concat(chunks);
        let data = JSON.parse(body.toString());
        let index = randomIntFromInterval(1, data.docs.length - 1);
        getInfo(data.docs[index].character);
    });

    res.on('error', function (error) {
        console.error(error);
    });
});

req.end();

function getInfo(character_id) {
    let options = {
        method: 'GET',
        hostname: 'the-one-api.dev',
        path: `/v2/character/${character_id}`,
        headers: {
            Authorization: `Bearer H604dyX39Xk3S7-g5WM-`,
        },
        maxRedirects: 20,
    };

    let req = https.request(options, function (res) {
        var chunks = [];

        res.on('data', function (chunk) {
            chunks.push(chunk);
        });

        res.on('end', function (chunk) {
            let body = Buffer.concat(chunks);
            let docs = JSON.parse(body.toString());
            console.log(docs);
        });

        res.on('error', function (error) {
            console.error(error);
        });
    });

    req.end();
}

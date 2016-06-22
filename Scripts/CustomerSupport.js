/*
 Copyright 2016 ykokw All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

module.exports = function(req, res){
  const NCMB = require("ncmb");
  const request = require("superagent");

  const mailAddress = req.body.mailAddress;
  const message = req.body.message;

  //NCMBのAPIキーを設定
  const ncmb = new NCMB(
    "YOUR_APP_KEY",
    "YOUR_CLIENT_KEY"
  );
  const Ticket = ncmb.DataStore("Tickets");
  const ticket = new Ticket({
    mailAddress: mailAddress,
    message: message
  });
  ticket.save()
    .then(function(apple){

      //SlackのWebhook URLを設定
      const url = "https://YOUR_INCOMING_WEBHOOK_URL"

      //登録がうまくいった場合に、slackへの通知を行う
      request.post(url)
      .send({text: "new message is arrived!"})
      .end(function (err, response) {
        if (err != null) {
          res.status(400)
            .set({"Content-type":"application/json"})
            .json({"error":err});
        } else {
          const apiKey = 'YOUR_API_KEY';
          const to = mailAddress;
          const from = 'no-reply@example.app.com';
          const subject = '問い合わせを受け付けました';
          const message = 'Sampleアプリのご利用ありがとうございます。\nお客様の問い合わせを受け付けました。弊社のスタッフが確認次第、ご連絡差し上げます。'
          const data = 'to=' + to + '&from=' + from + '&subject=' + subject + '&text=' + message;
          request
            .post('https://api.sendgrid.com/api/mail.send.json')
            .set('Authorization', 'Bearer ' + apiKey)
            .send(data)
            .end(function(err, response) {
              res.status(200)
                .set({"Content-type":"application/json"})
                .json({"result":"success."});
              }
            );
        }
      });
    })
    .catch(function(err){
      res.status(400).set({"Content-type":"application/json"}).json({"error":err});
    });
};

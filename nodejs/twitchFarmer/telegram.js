const axios = require('axios');

const myChatId = 539909763;
const url = `https://api.telegram.org/bot${process.env.telegram_token}/`;

let offset = 0;
async function start() {
  console.log('Starting Bot');
  const lastmessage = await getLastMessage();
  if(lastmessage) {
    offset = lastmessage.update_id + 1;
  }
  console.log('offset', offset);
}

function sendMessage(message) {
  console.log('url', url)
  axios.default.post(url + 'sendmessage' , {
    chat_id: myChatId,
    text: message
  })
}

function getLastMessage() {
  return axios.default.get(url + 'getUpdates' + '?offset=' + offset)
    .then(response => {
      console.log('rsponse', response)
      const lastMessage = response.data.result[response.data.result.length -1];
      if (lastMessage) {
        offset++;
      }
      return lastMessage;
    });
}

function askForTwitchCode() {
  sendMessage('Envie código para validar Login');
  return new Promise(async (resolve, reject) => {
   let waitTime = 1;
   const checkResponse = async () => {
    console.log('Checking response');
    const lastMessage = await getLastMessage();
    if (lastMessage) {
      return resolve(lastMessage.message.text);
    }
    setTimeout(checkResponse.bind(this), waitTime++ * 60 * 1000);
   }
   setTimeout(checkResponse.bind(this), 10 * 1000)
  });
}
exports.sendMessage =  sendMessage;
exports.askForTwitchCode = askForTwitchCode;
exports.start = start;

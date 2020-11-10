require('dotenv').config();

const puppeteer = require('puppeteer');
const accounts = require('./accounts.json');

const telegramBot = require('./telegram');
telegramBot.start();

(async () => {
  const browser = await puppeteer.launch({headless: false});
  const page = await browser.newPage();
  await page.goto('https://twitch.tv/login');


  
  
  await page.type('#login-username', accounts[0].username);
  await page.type('#password-input', accounts[0].password);
  await page.click('button.tw-border-bottom-left-radius-medium');
  
  await page.waitForSelector('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(1) > div > input')
  const code = await telegramBot.askForTwitchCode();
  console.log('code', code)
  await page.type('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(1) > div > input', code[0])
  await page.type('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(2) > div > input', code[1])
  await page.type('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(3) > div > input', code[2])
  await page.type('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(4) > div > input', code[3])
  await page.type('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(5) > div > input', code[4])
  await page.type('#root > div > div.scrollable-area > div.simplebar-scroll-content > div > div > div > div.tw-mg-b-1 > div:nth-child(2) > div > div:nth-child(6) > div > input', code[5])

  const mchPage = await browser.newPage();
  await mchPage.goto('https://twitch.tv/mch_agg');

  const tixinhaPage =  await browser.newPage();
  await tixinhaPage.goto('https://twitch.tv/tixinhadois');
})();
const {describe, it, before, afterEach} = require("mocha");
const asset = require("asset");
const Request = require("../src/request");
const { createSandbox} = require('sinon');

describe("Request Helpers", () => {
  let sandbox;
  let request;

  before(() => {
    sandbox = createSandbox()
    request = new Request();
  });

  afterEach(() => sandbox.restore);
  it("should test", () => {
    asset.ok(true);
  });
});
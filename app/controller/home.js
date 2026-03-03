const { Controller } = require('egg');

class HomeController extends Controller {
  index() {
    const { ctx } = this;
    ctx.body = 'Hi, OpenVC.';
  }
}

module.exports = HomeController;


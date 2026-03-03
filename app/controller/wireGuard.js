'use strict';

const { Controller } = require('egg');
const { exec } = require('node:child_process');
const { promisify } = require('node:util');
const execAsync = promisify(exec);

class WireGuardController extends Controller {
  async setCMDInfo() {
    const { ctx, app } = this;
    try {
      const { stdout, stderr } = await execAsync('dir');
      ctx.body = {
        code: 0,
        message: 'success',
        result: { stdout, stderr },
      };
    } catch (e) {
      app.logger.error(e);
      ctx.status = 500;
      ctx.body = {
        code: 1,
        message: 'command error',
        result: String(e && e.message ? e.message : e),
      };
    }
  }
}

module.exports = WireGuardController;

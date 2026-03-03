'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  router.get('/', controller.home.index);
  router.get('/api/v1/user/info', controller.user.userInfo);
  router.post('/api/v1/user/login', controller.user.userLogin);
  router.post('/api/v1/user/register', controller.user.userRegister);
  router.get('/api/v1/wireguard/cmd', controller.wireGuard.setCMDInfo);
};

import http from 'k6/http';
import { check } from 'k6';
import config from '../config.js';

const params = {
  headers: {
    'x-api-key': config.apiKey,
  },
};

export function deleteUser() {
  const userId = 2;

  const res = http.del(`${config.baseUrl}/api/users/${userId}`, null, params);

  check(res, {
    'deleteUser status is 204': (r) => r.status === 204,
  });
}

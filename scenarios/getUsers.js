import http from 'k6/http';
import { check } from 'k6';
import config from '../config.js';

export function getUsers() {
  const res = http.get(`${config.baseUrl}/api/users?page=2`, {
    headers: {
      'x-api-key': config.apiKey,
      'Content-Type': 'application/json',
    },
  });

  check(res, {
    'getUsers status is 200': (r) => r.status === 200,
    'users data present': (r) => JSON.parse(r.body).data !== undefined,
  });
}

import http from 'k6/http';
import { check } from 'k6';
import config from '../config.js';

const params = {
  headers: {
    'Content-Type': 'application/json',
    'x-api-key': config.apiKey,
  },
};

export function updateUser() {
  const userId = 2;
  const payload = JSON.stringify({
    name: 'morpheus',
    job: 'zion resident',
  });

  const res = http.put(`${config.baseUrl}/api/users/${userId}`, payload, params);

  check(res, {
    'updateUser status is 200': (r) => r.status === 200,
    'updated job correct': (r) => r.json('job') === 'zion resident',
  });
}

import http from 'k6/http';
import { check } from 'k6';
import config from '../config.js';

const params = {
  headers: {
    'Content-Type': 'application/json',
    'x-api-key': config.apiKey,
  },
};

export function createUser() {
  const payload = JSON.stringify({
    name: 'morpheus',
    job: 'leader',
  });

  const res = http.post(`${config.baseUrl}/api/users`, payload, params);

  check(res, {
    'createUser status is 201': (r) => r.status === 201,
    'id received': (r) => JSON.parse(r.body).id !== undefined,
  });
}

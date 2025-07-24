import { sleep } from 'k6';

import { getUsers } from './scenarios/getUsers.js';
import { createUser } from './scenarios/createUser.js';
import { updateUser } from './scenarios/updateUser.js';
import { deleteUser } from './scenarios/deleteUser.js';

export default function () {

  getUsers();
  sleep(1);

  createUser();
  sleep(1);

  updateUser();
  sleep(1);

  deleteUser();
  sleep(1);
}

const ENV = __ENV.ENV || 'dev';

const configData = JSON.parse(open(`./environments/${ENV}.env.json`));

export default configData;
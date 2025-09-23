function fn() {
  var env = karate.env; // get java system property 'karate.env'
  var urlBase = ''

  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }

  if (env == 'dev') {
    urlBase = 'https://serverest.dev';

  } else if (env == 'cert') {
    urlBase = 'https://serverest.dev';
  }

var config = { // base config JSON
  env: env,
  urlBase: urlBase,
  };

  return config;
}
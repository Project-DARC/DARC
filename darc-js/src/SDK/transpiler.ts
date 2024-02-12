export function transpile(sourceCode: string): string {

  // compile the source code with babel standalone
  const babel = require('@babel/standalone');

  // register the plugin

  babel.registerPlugin('overload', require('@jetblack/operator-overloading')); //jetblack_operator_overload);
  

  // register the preset
  babel.registerPreset('@babel/preset-env', require('@babel/preset-env'));


  // register the typescript preset
  babel.registerPreset('@babel/preset-typescript', require('@babel/preset-typescript'));

  // compile the code
  const result = babel.transform(      `'operator-overloading enabled';` + sourceCode, {
    plugins: ['overload'], //, '@babel/plugin-proposal-class-properties', '@babel/plugin-proposal-private-methods'],
    //['@babel/plugin-proposal-class-properties', { "loose": true }],
    //['@babel/plugin-proposal-private-methods', { loose: true }]

    presets: ['@babel/preset-env', '@babel/preset-typescript'],
    filename: 'source.ts',
    sourceType: 'script'
  });

  

  return result.code;
}
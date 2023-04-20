export function transpiler(sourceCode: string): string {

  // compile the source code with babel standalone
  const babel = require('@babel/standalone');

  // register the plugin

  babel.registerPlugin('overload', require('@jetblack/operator-overloading')); //jetblack_operator_overload);

  /*
  babel.registerPlugin(
    '@babel/plugin-proposal-class-properties',
     require('@babel/plugin-proposal-class-properties')
  );
  babel.registerPlugin(
    '@babel/plugin-proposal-private-methods',
    require('@babel/plugin-proposal-private-methods')
  );

    function lolizer() {
    return {
      visitor: {
        Identifier(path:any) {
          console.log(JSON.stringify( path.node));
          //path.node.name = "LOL";
        },
      },
    };
  }

  babel.registerPlugin("lolizer", lolizer);
  */
  

  // register the preset
  babel.registerPreset('@babel/preset-env', require('@babel/preset-env'));


  // register the typescript preset
  babel.registerPreset('@babel/preset-typescript', require('@babel/preset-typescript'));

  // compile the code
  const result = babel.transform(sourceCode, {
    plugins: ['overload'], //, '@babel/plugin-proposal-class-properties', '@babel/plugin-proposal-private-methods'],
    //['@babel/plugin-proposal-class-properties', { "loose": true }],
    //['@babel/plugin-proposal-private-methods', { loose: true }]

    presets: ['@babel/preset-env', '@babel/preset-typescript'],
    filename: 'source.ts',
    sourceType: 'script'
  });

  console.log(JSON.stringify(babel));

  return  result.code;
}
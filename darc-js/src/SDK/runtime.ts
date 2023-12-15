import * as instructions from "./instructions";

export function run(code:string) {
  let include = '';
  for (const key in instructions) {
    include += `let ${key} = instructions.${key};\n`;
  }
}
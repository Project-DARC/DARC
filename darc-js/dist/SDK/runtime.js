import * as instructions from "./instructions";
export function run(code) {
    let include = '';
    for (const key in instructions) {
        include += `let ${key} = instructions.${key};\n`;
    }
}
//# sourceMappingURL=runtime.js.map
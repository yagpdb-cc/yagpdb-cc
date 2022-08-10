const { promisify } = require('node:util');
const exec = promisify(require('node:child_process').exec);
const { writeFile } = require('fs/promises');
const { join } = require('path');

const SYNTAX_HIGHLIGHTING_FUNCS_FILE = join(__dirname, '../website/src/custom-languages/prism-gotmpl/funcs.js');
const TEMPLATE = `export const funcs = [
{{FUNCS}}
];
`;

async function main() {
	const { stdout } = await exec('lytfs');
	const funcs = stdout.trim().split('\n').sort();
	await writeFile(
		SYNTAX_HIGHLIGHTING_FUNCS_FILE,
		TEMPLATE.replace('{{FUNCS}}', funcs.map((func) => `\t'${func}',`).join('\n')),
	);
}

main();

import { funcs } from './funcs';

Prism.languages.gotmpl = {
	comment: /{{\/\*.+?\*\/}}/s,
	string: {
		pattern: /(^|[^\\])"(?:\\.|[^"\\\r\n])*"|`[^`]*`/,
		lookbehind: true,
		greedy: true,
	},
	keyword: /\b(?:if|else|end|range|while|break|continue|try|catch|return|template|define|block|with)\b/,
	boolean: /\b(?:nil|true|false)\b/,
	number: [
		// binary and octal integers
		/\b0(?:b[01_]+|o[0-7_]+)i?\b/i,
		// hexadecimal integers and floats
		/\b0x(?:[a-f\d_]+(?:\.[a-f\d_]*)?|\.[a-f\d_]+)(?:p[+-]?\d+(?:_\d+)*)?i?(?!\w)/i,
		// decimal integers and floats
		/(?:\b\d[\d_]*(?:\.[\d_]*)?|\B\.\d[\d_]*)(?:e[+-]?[\d_]+)?i?(?!\w)/i,
	],
	builtin: /\b(?:call|html|index|slice|js|len|print(?:f|ln)|urlquery|execTemplate)\b/,
	operator: /\b(?:eq|ne|lt|le|gt|ge|not|and|or)\b/,
	variable: /\$(?:[A-Za-z_]\w*)?\b/,
	function: new RegExp(String.raw`\b(?:${funcs.join('|')})\b`),
	char: {
		pattern: /'(?:\\.|[^'\\\r\n]){0,10}'/,
		greedy: true,
	},
};

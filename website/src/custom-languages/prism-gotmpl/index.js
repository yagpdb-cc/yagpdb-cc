import { funcs } from './funcs';

Prism.languages.gotmpl = {
	comment: /{{\/\*.+?\*\/}}/s,
	string: {
		pattern: /(["`])(?:\\[\s\S]|(?!\1)[^\\])*\1/,
		greedy: true,
	},
	keyword: /\b(?:if|range|template|define|block|with|else)\b/,
	boolean: /\b(?:nil|true|false)\b/,
	number: /(?:\b0x[a-f\d]+|(?:\b\d+(?:\.\d*)?|\B\.\d+)(?:e[-+]?\d+)?)i?/i,
	builtin: /\b(?:call|html|index|slice|js|len|print(?:f|ln)|urlquery)\b/,
	operator: /\b(?:eq|ne|lt|le|gt|ge|not|and|or)\b/,
	variable: /\$(?:[A-Za-z_]\w*)?\b/,
	function: new RegExp(String.raw`\b(?:${funcs.join('|')})\b`),
	char: /'.'/,
};

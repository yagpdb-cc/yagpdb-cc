const theme = {
	plain: {
		color: '#000000',
		backgroundColor: '#F6F7F6',
	},
	styles: [
		{
			types: ['comment', 'punctuation', 'string', 'builtin'],
			style: {
				color: 'rgb(106, 115, 125)',
			},
		},
		{
			types: ['constant', 'variable'],
			style: {
				color: 'rgb(0, 92, 197)',
			},
		},
		{
			types: ['operator'],
			style: {
				color: 'rgb(0, 0, 0)',
			},
		},
		{
			types: ['tag', 'inserted'],
			style: {
				color: 'rgb(34, 134, 58)',
			},
		},
		{
			types: ['deleted', 'keyword'],
			style: {
				color: 'rgb(179, 29, 40)',
			},
		},
		{
			types: ['changed'],
			style: {
				color: 'rgb(227, 98, 9)',
			},
		},
	],
};

module.exports = theme;

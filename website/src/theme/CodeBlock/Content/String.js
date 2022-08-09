import { usePrismTheme, useThemeConfig } from '@docusaurus/theme-common';
import {
	containsLineNumbers,
	parseCodeBlockTitle,
	parseLanguage,
	parseLines,
	useCodeWordWrap,
} from '@docusaurus/theme-common/internal';
import Container from '@theme/CodeBlock/Container';
import CopyButton from '@theme/CodeBlock/CopyButton';
import Line from '@theme/CodeBlock/Line';
import WordWrapButton from '@theme/CodeBlock/WordWrapButton';
import clsx from 'clsx';
import Highlight, { defaultProps } from 'prism-react-renderer';
import React from 'react';
import styles from './styles.module.css';
export default function CodeBlockString({
	children,
	className: blockClassName = '',
	metastring,
	title: titleProp,
	showLineNumbers: showLineNumbersProp,
	language: languageProp,
}) {
	const {
		prism: { defaultLanguage, magicComments },
	} = useThemeConfig();
	const language = languageProp ?? parseLanguage(blockClassName) ?? defaultLanguage;
	const prismTheme = usePrismTheme();
	const wordWrap = useCodeWordWrap();
	// We still parse the metastring in case we want to support more syntax in the
	// future. Note that MDX doesn't strip quotes when parsing metastring:
	// "title=\"xyz\"" => title: "\"xyz\""
	const title = parseCodeBlockTitle(metastring) || titleProp;
	const { lineClassNames, code: originalCode } = parseLines(children, {
		metastring,
		language,
		magicComments,
	});
	// Workaround MDX converting tabs to spaces in codeblocks
	const code = originalCode.replace(/^\s+/gm, (leadingSpaces) => leadingSpaces.replace(/ {4}/g, '\t'));
	const showLineNumbers = showLineNumbersProp ?? containsLineNumbers(metastring);
	return (
		<Container
			as="div"
			className={clsx(
				blockClassName,
				language && !blockClassName.includes(`language-${language}`) && `language-${language}`,
			)}
		>
			{title && <div className={styles.codeBlockTitle}>{title}</div>}
			<div className={styles.codeBlockContent}>
				<Highlight {...defaultProps} theme={prismTheme} code={code} language={language ?? 'text'}>
					{({ className, tokens, getLineProps, getTokenProps }) => (
						<pre
							/* eslint-disable-next-line jsx-a11y/no-noninteractive-tabindex */
							tabIndex={0}
							ref={wordWrap.codeBlockRef}
							className={clsx(className, styles.codeBlock, 'thin-scrollbar')}
						>
							<code className={clsx(styles.codeBlockLines, showLineNumbers && styles.codeBlockLinesWithNumbering)}>
								{tokens.map((line, i) => (
									<Line
										key={i}
										line={line}
										getLineProps={getLineProps}
										getTokenProps={getTokenProps}
										classNames={lineClassNames[i]}
										showLineNumbers={showLineNumbers}
									/>
								))}
							</code>
						</pre>
					)}
				</Highlight>
				<div className={styles.buttonGroup}>
					{(wordWrap.isEnabled || wordWrap.isCodeScrollable) && (
						<WordWrapButton
							className={styles.codeButton}
							onClick={() => wordWrap.toggle()}
							isEnabled={wordWrap.isEnabled}
						/>
					)}
					<CopyButton className={styles.codeButton} code={code} />
				</div>
			</div>
		</Container>
	);
}

#!/usr/bin/env node
import { fileURLToPath } from 'url';
import fs from 'fs/promises';
import { join, parse, dirname } from 'path';

// At the root, the introduction comes first, then the adding custom commands page.
const rootSpecialCases = ['introduction', 'adding-ccs'];
// In other sections, the overview page comes first.
const subdirectorySpecialCases = ['overview'];

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const websiteDocsDir = join(__dirname, '..', 'website', 'docs');

await fixSidebarPositions(websiteDocsDir, rootSpecialCases);
console.log('Fixed sidebar positions for all files.');

async function fixSidebarPositions(dirname, specialCases) {
	const dirents = await fs.readdir(dirname, { withFileTypes: true });

	const promises = [];
	const rest = [];
	for (const dirent of dirents) {
		// Ignore _category_.json.
		if (dirent.name === '_category_.json') continue;

		// Is it a special case?
		if (!dirent.isDirectory()) {
			// indexOf returns 0-based, adjust it to be 1-based.
			const position = specialCases.indexOf(parse(dirent.name).name) + 1;
			if (position > 0) {
				promises.push(setFileSidebarPosition(join(dirname, dirent.name), position));
				continue;
			}
		}

		rest.push(dirent);
	}

	promises.push(
		...rest.sort(comparator).map((dirent, index) => {
			// Special cases are already in promises and come before all other files,
			// so the position needs to be incremented by the number of special cases.
			// Also, the index is 0-based, convert it to 1-based before adding.
			const actualPosition = index + 1 + promises.length;

			const fullPath = join(dirname, dirent.name);
			return dirent.isDirectory()
				? setDirectorySidebarPosition(fullPath, actualPosition).then(() =>
						fixSidebarPositions(fullPath, subdirectorySpecialCases),
				  )
				: setFileSidebarPosition(fullPath, actualPosition);
		}),
	);
	return Promise.all(promises);
}

async function setDirectorySidebarPosition(dirname, position) {
	const categoryInfoFilename = join(dirname, '_category_.json');
	const categoryInfo = JSON.parse(await fs.readFile(categoryInfoFilename, { encoding: 'utf8' }));
	categoryInfo.position = position;

	const json = JSON.stringify(categoryInfo, null, '\t');
	await fs.writeFile(categoryInfoFilename, json + '\n', { encoding: 'utf8' });
}

async function setFileSidebarPosition(filename, position) {
	const content = await fs.readFile(filename, { encoding: 'utf8' });
	const newContent = content.replace(/^sidebar_position:\s+\d+\s*$/m, `sidebar_position: ${position}`);
	await fs.writeFile(filename, newContent);
}

function comparator(a, b) {
	// Directories come first.
	if (a.isDirectory() && !b.isDirectory()) return -1;
	if (b.isDirectory() && !a.isDirectory()) return 1;

	// Use lexicographical order.
	if (a.name === b.name) return 0;
	return a.name > b.name ? 1 : -1;
}

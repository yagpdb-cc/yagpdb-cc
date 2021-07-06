import React from 'react';

const allPermissions = [
	'Administrator',
	'ManageServer',
	'ReadMessages',
	'SendMessages',
	'SendTTSMessages',
	'ManageMessages',
	'EmbedLinks',
	'AttachFiles',
	'ReadMessageHistory',
	'MentionEveryone',
	'VoiceConnect',
	'VoiceSpeak',
	'VoiceMuteMembers',
	'VoiceDeafenMembers',
	'VoiceMoveMembers',
	'VoiceUseVAD',
	'ManageNicknames',
	'ManageRoles',
	'ManageWebhooks',
	'ManageEmojis',
	'CreateInstantInvite',
	'KickMembers',
	'BanMembers',
	'ManageChannels',
	'AddReactions',
	'ViewAuditLogs',
];

export const AvailablePermissionsDisplay = () => (
	<details>
		<summary>
			<strong>Available permissions:</strong>
		</summary>
		<ul>
			{allPermissions.map((permission) => (
				<li>
					<code>{permission}</code>
				</li>
			))}
		</ul>
	</details>
);

CREATE TABLE koi_test.names(
	ref BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	uid BIGINT NOT NULL,
	name TEXT NOT NULL NOT NULL,
	first_seen TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP);

CREATE INDEX ON names (uid);

CREATE TABLE koi_test.discrims(
	ref BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	uid BIGINT NOT NULL,
	discrim TEXT NOT NULL,
	first_seen TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP);

CREATE INDEX ON discrims (uid);

CREATE TABLE koi_test.nicks(
	ref BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	uid BIGINT NOT NULL,
	sid BIGINT NOT NULL,
	nick TEXT,
	first_seen TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP);

CREATE INDEX ON nicks (uid, sid);

CREATE TYPE status AS ENUM ('online', 'offline', 'invisible', 'dnd', 'idle', 'cog_offline', 'cog_online', 'left_guild');

CREATE TABLE koi_test.statuses(
	ref BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	uid BIGINT NOT NULL,
	status status NOT NULL,
	first_seen TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP);

CREATE INDEX "statuses_uid_first_seen_idx" ON statuses (uid, first_seen DESC NULLS LAST);
CLUSTER statuses USING statuses_uid_first_seen_idx;

CREATE TYPE koi_test.cog_event AS ENUM ('cog_offline', 'cog_online');

CREATE TABLE koi_test.cog_log(
	ref BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	event cog_event NOT NULL,
	time TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP);

-- for users that the bot cannot see at all
CREATE TABLE koi_test.member_removes(
	ref BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
	uid BIGINT NOT NULL,
	time TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE koi_test.presence_whitelist(
	uid BIGINT PRIMARY KEY,
	keep BOOLEAN NOT NULL);
